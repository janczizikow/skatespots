# frozen_string_literal: true

module Geocode
  extend ActiveSupport::Concern

  included do
    geocoded_by :address
    after_validation :geocode, if: :will_save_change_to_address?
    before_create :set_country
    before_update :set_country
  end

  private

  def set_country
    result = Geocoder.search(address)
    self.country = result.first.country if result.present?
  end
end
