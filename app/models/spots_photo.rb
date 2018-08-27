# frozen_string_literal: true

class SpotsPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  mount_uploader :photo, PhotoUploader
end