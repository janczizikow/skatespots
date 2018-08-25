# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  it('cannot be saved without a city') do
    spot = Spot.new
    spot.name = 'Woodward park'
    spot.address = 'Random St. 2'
    expect(spot).to_not be_valid
  end

  it('cannot be saved without address') do
    spot = Spot.new(name: 'Woodward park', address: 'Random St. 2')
    expect(spot).to_not be_valid
  end

  it('cannot be saved without a name') do
    spot = Spot.new
    expect(spot).to_not be_valid
  end
end
