# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  it('cannot be saved without a name') do
    city = City.new
    expect(city).to_not be_valid
  end

  it('cannot be saved with a duplicate name') do
    create(:city)
    city = City.new(name: 'warsaw')
    expect(city).to_not be_valid
  end
end
