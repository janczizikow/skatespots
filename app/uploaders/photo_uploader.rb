# frozen_string_literal: true

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  version :placeholder do
    resize_to_fit(16, 9)
  end

  version :thumbnail do
    cloudinary_transformation width: 800, crop: :fill
  end
end
