# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_spot
  before_action :set_review, only: %i[update destroy]

  def create
    @review = Review.new(review_params)
    @review.spot = @spot
    @review.user = current_user
    authorize @review

    if @review.save
      flash[:notice] = 'Review added'
      respond_to do |format|
        format.html { redirect_to spot_path(@spot) }
        format.js
      end
    else
      flash[:alert] = @review.errors.full_messages
      respond_to do |format|
        format.html { render 'spots/show' }
        format.js
      end
    end
  end

  def update
    if @review.update(review_params)
      flash[:notice] = 'Review updated'
      redirect_to @spot
    else
      flash[:alert] = @review.errors.full_messages
      render 'spots/show'
    end
  end

  def destroy
    if @review.destroy
      flash[:notice] = 'Review removed'
      respond_to do |format|
        format.html { render 'spots/show' }
        format.js
      end
    else
      flash[:alert] = @review.errors.full_messages
      render 'spots/show'
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def set_spot
    @spot = Spot.friendly.find(params[:spot_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
