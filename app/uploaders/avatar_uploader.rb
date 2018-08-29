# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true # Force version generation at upload time.
  process resize_to_fit: [400, 400]

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
