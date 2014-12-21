# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    name = [mounted_as, 'default', version_name].compact.join('_')
    "fallback/#{name}.png"
  end

  version :small do # 350x350 non retina
    process resize_to_fit: [700, 700]
  end

  version :thumb do # 100x100 non retina
    process resize_to_fill: [200, 200]
  end

  version :catalog_preview do # 100x85 non retina
    process resize_to_fill: [200, 170]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{uuid}.#{file.extension}" if original_filename
  end

  private

  def uuid
    var = :"@#{mounted_as}_uuid"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
