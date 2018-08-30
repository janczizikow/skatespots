# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_spot, only: %i[create destroy]

  def index
    @favorites = policy_scope(Favorite)
    authorize @favorites
  end

  def create
    @favorite = Favorite.new
    @favorite.spot = @spot
    @favorite.user = current_user

    authorize @favorite

    if @favorite.save
      flash[:notice] = 'Spot added to favorites'
      respond_to do |format|
        format.html { redirect_to spot_path(@spot) }
        # format.js
      end
    else
      flash[:alert] = @favorite.errors.full_messages
      respond_to do |format|
        format.html { render 'spots/show' }
        # format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, spot_id: favorite_params[:spot_id])
    authorize @favorite
    if @favorite.destroy
      flash[:notice] = 'Spot removed from favorites'
      redirect_to @spot
    else
      flash[:alert] = @favorite.errors.full_messages
      render :index
    end
  end

  private

  def set_spot
    @spot = Spot.friendly.find(params[:spot_id])
  end

  def favorite_params
    params.require(:favorite).permit(:spot_id, :favorite_id)
  end
end
