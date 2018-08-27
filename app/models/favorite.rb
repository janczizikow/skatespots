# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :spot, uniqueness: {scope: :user}
end
