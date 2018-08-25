# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :user, presence: true
  validates :rating, inclusion: {in: [1, 2, 3, 4, 5]}
end
