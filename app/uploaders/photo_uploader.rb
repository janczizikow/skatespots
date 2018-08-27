# frozen_string_literal: true

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
