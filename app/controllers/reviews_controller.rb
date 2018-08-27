# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_spot

  def create
    @review = Review.new(review_params)
    @review.spot = @spot
    @review.user = current_user
    authorize @review

    if @review.save
      respond_to do |format|
        format.html { redirect_to spot_path(@spot) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'spots/show' }
        format.js
      end
    end
  end

  def destroy
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
