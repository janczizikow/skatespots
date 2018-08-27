# frozen_string_literal: true

class AddPhoto
  def initialize(params)
    @params = params
  end

  def call
    add_photo
  end

  private

  def add_photo
    new_photo
    if @photo.save
      Command::Result::Success.new(@photo)
    else
      Command::Result::Error.new(@photo.errors)
    end
  end

  def new_photo
    @photo = SpotsPhoto.new(
      user_id: @params[:user].id,
      spot_id: @params[:spot].id,
      photo: @params[:photo]
    )
  end
end
