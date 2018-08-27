# frozen_string_literal: true

class Spot < ApplicationRecord
  include PgSearch

  belongs_to :city
  belongs_to :user

  has_many :spots_photos, dependent: :restrict_with_exception
  has_many :reviews, dependent: :restrict_with_exception

  validates :city, presence: true
  validates :name, presence: true
  validates :address, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  pg_search_scope :global_location_search,
                  against: %i[name address],
                  associated_against: {
                    city: [:name]
                  },
                  using: {
                    tsearch: {prefix: true}
                  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
