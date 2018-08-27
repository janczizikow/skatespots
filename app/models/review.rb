# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :spot, presence: true
  validates :user, presence: true
  validates :rating, presence: true, inclusion: {in: [1, 2, 3, 4, 5]}
end
