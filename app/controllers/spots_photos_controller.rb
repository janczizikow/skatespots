# frozen_string_literal: true

class SpotsPhotosController < ApplicationController
  before_action :set_spot

  def create
    @photo = SpotsPhoto.new(spots_photo_params)
    @photo.spot = @spot
    @photo.user = current_user
    authorize @photo
    if @photo.save
      redirect_to spot_path(@spot)
    else
      render 'spots/show'
    end
  end

  def destroy
    @photo.find(params[:id])
    authorize @photo
    if @photo.destroy
      flash[:notice] = 'Photo removed'
      redirect_to @spot
    else
      flash[:alert] = @photo.errors.full_messages
      render :spot
    end
  end

  private

  def set_spot
    @spot = Spot.friendly.find(params[:spot_id])
  end

  def spots_photo_params
    params.require(:spots_photo).permit(:photo)
  end
end
