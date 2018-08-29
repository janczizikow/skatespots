# frozen_string_literal: true

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = policy_scope(Spot.active.where(nil))
    # Alternatively this can be done by geocoder
    # policy_scope(Spot.active.near(params[:query]))
    @spots = policy_scope(Spot.active).global_location_search(params[:query]) if params[:query].present?
    @spots = policy_scope(Spot.active).category_search(params[:category]) if params[:category].present?
    set_spots_markers
  end

  def show
    @spots_photo = SpotsPhoto.new
    @spots_nearby = if @spot.geocoded?
                      @spot.nearbys(10).limit(6)
                    else
                      []
                    end
    @markers = [{
      lat: @spot.latitude,
      lng: @spot.longitude,
      infoWindow: {
        content: render_to_string(partial: '/spots/map_box', locals: {spot: @spot}),
        'maxWidth': 280
      }
    }]
  end

  def new
    @spot = Spot.new
    authorize @spot
  end

  def create
    city_result = CreateCity.new(city: spot_params[:city]).call
    if city_result.success?
      city = city_result.data
    else
      render :new, error: city_result.error
    end

    @spot = Spot.new(spot_params.merge(city: city).merge(user: current_user))

    authorize @spot

    if @spot.save
      redirect_to @spot
    else
      render :new
    end
  end

  def edit; end

  def update
    city_result = CreateCity.new(city: spot_params[:city]).call
    if city_result.success?
      city = city_result.data
    else
      render :edit, error: city_result.error
    end

    if @spot.update(
      name: spot_params[:name],
      address: spot_params[:address],
      description: spot_params[:description],
      city_id: city.id
    )
      redirect_to @spot
    else
      render :edit
    end
  end

  def destroy
    @spot.active = false
    if @spot.save
      redirect_to spots_path
    else
      render :show
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
    authorize @spot
  end

  def spot_params
    params.require(:spot).permit(:name, :description, :address, :city,
                                 spots_photos_attributes: %i[user_id photo],
                                 spots_categories_attributes: :category_id)
  end

  def set_spots_markers
    if @spots.present?
      @markers = @spots.where.not(latitude: nil, longitude: nil).map do |spot|
        {
          lat: spot.latitude,
          lng: spot.longitude,
          infoWindow: {
            content: render_to_string(partial: '/spots/map_box', locals: {spot: spot}),
            'maxWidth': 280
          }
        }
      end
    end
  end
end
