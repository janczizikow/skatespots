# frozen_string_literal: true

class SpotsCategory < ApplicationRecord
  belongs_to :spot, inverse_of: :spots_categories
  belongs_to :category

  validates :spot, presence: true
  validates :category, presence: true

  validates :spot, uniqueness: {scope: :category}
end
