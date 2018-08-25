# frozen_string_literal: true

class City < ApplicationRecord
  has_many :users
  has_many :spots

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
