# frozen_string_literal: true

class Spot < ApplicationRecord
  belongs_to :city
  has_many :reviews, dependent: :destroy

  validates :city, presence: true
  validates :name, presence: true
  validates :address, presence: true
end
