# frozen_string_literal: true

class Spot < ApplicationRecord
  include PgSearch

  belongs_to :city
  belongs_to :user

  has_many :spots_categories, inverse_of: :spot, dependent: :restrict_with_exception
  has_many :categories, through: :spots_categories
  has_many :spots_photos, inverse_of: :spot, dependent: :destroy
  # has_many :photos,
           # class_name: 'SpotsPhoto', foreign_key: 'spot_id',
           # dependent: :restrict_with_exception
  has_many :reviews, dependent: :restrict_with_exception
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :spots_photos, reject_if: proc { |attributes| attributes[:photo].blank? }
  accepts_nested_attributes_for :spots_categories, reject_if: proc { |attributes| attributes[:category_id].blank? }

  validates :city, presence: true
  validates :name, presence: true
  validates :address, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :user_spots, ->(current_user) { where(user_id: current_user.id) }

  pg_search_scope :global_location_search,
                  against: %i[name address country],
                  associated_against: {
                    city: [:name],
                    categories: [:name]
                  },
                  using: {
                    tsearch: {prefix: true}
                  }
  pg_search_scope :category_search,
                  associated_against: {
                    categories: [:name]
                  }, using: {
                    tsearch: {prefix: true}
                  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
