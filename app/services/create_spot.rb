# frozen_string_literal: true

class CreateSpot
  def initialize(params)
    @params = params
  end

  def call
    create_spot
  end

  private

  def create_spot
    new_spot
    @spot.city = @params[:city]
    @spot.user = @params[:user]
    if @spot.save
      Command::Result::Success.new(@spot)
    else
      Command::Result::Error.new(@spot.errors)
    end
  end

  def new_spot
    @spot = Spot.new(
      name: @params[:name],
      address: @params[:address],
      description: @params[:description]
    )
  end
end
