# frozen_string_literal: true

class SpotsPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :spot, inverse_of: :spots_photos

  mount_uploader :photo, PhotoUploader
  validates :photo, presence: true
end
