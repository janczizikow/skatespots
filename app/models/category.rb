# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :spots_categories, dependent: :destroy
  has_many :spots, through: :spots_categories

  validates :name, presence: true, uniqueness: {case_sensitive: false}, inclusion: {
    in:
      %w[Street Skatepark Indoor Outdoor Rails Stairs Mini Bowl]
  }
end
