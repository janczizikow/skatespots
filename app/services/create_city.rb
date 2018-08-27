# frozen_string_literal: true

class CreateCity
  def initialize(params)
    @params = params
  end

  def call
    create_city
  end

  private

  def create_city
    if city_exists?
      city = City.find_by(name: @params[:city])
      Command::Result::Success.new(city)
    else
      add_city
    end
  end

  def add_city
    city = City.new(name: @params[:city])
    if city.save
      Command::Result::Success.new(city)
    else
      Command::Result::Error.new(city.errors)
    end
  end

  def city_exists?
    City.find_by(name: @params[:city]).present?
  end
end
