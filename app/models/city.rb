# frozen_string_literal: true

class City < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception
  has_many :spots, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
