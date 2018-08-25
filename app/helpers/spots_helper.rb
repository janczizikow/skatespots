# frozen_string_literal: true

module SpotsHelper
  def city
    @spot.city.name
  end

  def review
    Review.new
  end

  def reviews_count
    @spot.reviews.length
  end

  def rating
    @spot.reviews&.average(:rating) || 0
  end
end
