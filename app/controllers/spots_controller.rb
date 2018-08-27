# frozen_string_literal: true

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = if params[:query].present?
               policy_scope(Spot.active).global_location_search(params[:query])
             else
               policy_scope(Spot.active)
             end
    set_spots_markers
  end

  def show
    @spots_photo = SpotsPhoto.new
    @markers = [{
      id: "#{@spot.id}#",
      title: @spot.name,
      address: @spot.address,
      photo: @spot.spots_photos.first.photo,
      lat: @spot.latitude,
      lng: @spot.longitude
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
      render :create
    end

    spot_result = CreateSpot.new(spot_params.merge(city: city).merge(user: current_user)).call
    if spot_result.success?
      @spot = spot_result.data
    else
      render :create
    end

    photo_result = AddPhoto.new(user: current_user, spot: @spot, photo: spot_params[:photo]).call

    authorize @spot

    if photo_result.success?
      redirect_to @spot
    else
      render :new
    end
  end

  def edit; end

  def update
    if @spot.update(
      name: spot_params[:name],
      address: spot_params[:address],
      description: spot_params[:description]
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
    params.require(:spot).permit(:name, :description, :address, :city, :photos, :photo)
  end

  def set_spots_markers
    @markers = @spots.where.not(latitude: nil, longitude: nil).map do |spot|
      {
        id: spot.id,
        title: spot.name,
        address: spot.address,
        photo: spot.spots_photos.first.photo,
        lat: spot.latitude,
        lng: spot.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end
end
