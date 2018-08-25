# frozen_string_literal: true

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = policy_scope(Spot)
  end

  def show; end

  def new
    @spot = Spot.new
    authorize @spot
  end

  def create
    City.create(name: spot_params[:city]) if City.find_by(name: spot_params[:city]).blank?
    @spot = Spot.new(
      name: spot_params[:name],
      address: spot_params[:address]
    )
    @spot.city = City.find_by(name: spot_params[:city])
    authorize @spot
    if @spot.save
      redirect_to @spot
    else
      render :new
    end
  end

  def edit; end

  def update
    if @spot.update(spot_params)
      redirect_to @spot
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
    authorize @spot
  end

  def spot_params
    params.require(:spot).permit(:name, :description, :address, :city)
  end
end
