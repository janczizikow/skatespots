# frozen_string_literal: true

module SpotsHelper
  include Pagy::Frontend
  def spots?
    @spots.present?
  end

  def num_of_spots
    @pagy.count > 1 ? "#{@pagy.count} Spots" : "#{@pagy.count} Spot"
  end

  def city
    @spot.city.name
  end

  def user
    @spot.user
  end

  def user_photo
    @spot.user.avatar
  end

  def review
    Review.new
  end

  def favorite
    Favorite.new
  end

  def in_favorites(spot)
    Favorite.find_by(user_id: current_user.id, spot_id: spot.id) if user_signed_in?
  end

  def spots_photo
    SpotsPhoto.new
  end

  def photos
    # TODO: Add this helper
  end

  def reviews
    @spot.reviews
  end

  def reviews_count(spot)
    spot.reviews.length
  end

  def rating(spot)
    spot.reviews&.average(:rating) || 0
  end
end
