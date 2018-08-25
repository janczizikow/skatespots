# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_spot

  def create
    @review = Review.new(review_params)
    @review.spot = @spot
    authorize @review

    if @review.save
      # TODO: ADD AJAX
    else

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
