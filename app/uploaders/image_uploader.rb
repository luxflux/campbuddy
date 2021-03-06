# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :jpgize

  def store_dir
    "#{Rails.env}/#{Apartment::Tenant.current}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    name = [mounted_as, version_name].compact.join('_')
    "fallback/#{name}.jpg"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp tif tiff)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{uuid}.jpg" if original_filename
  end

  def uses_fallback?
    url == default_url
  end

  private

  def uuid
    var = :"@#{mounted_as}_uuid"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

  def jpgize
    manipulate! do |img|
      img.format('jpg') do |convert|
        convert <<         '-auto-orient'
        convert <<         '+profile'
        convert.+          '*'
        convert.profile    "#{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
        convert.colorspace "sRGB"
      end
      img
    end
  end
end
