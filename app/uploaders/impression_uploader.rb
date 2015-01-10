# encoding: utf-8

class ImpressionUploader < ImageUploader
  process :convert_to_grayscale

  version :detail do # 1440 non retina
    process resize_to_fit: [2880, 2880]
  end

  version :catalog do # 100x85 non retina
    process resize_to_fill: [200, 170]
  end

  def convert_to_grayscale
    manipulate! do |img|
      img.colorspace('Gray')
      img.brightness_contrast('10x0')
      img = yield(img) if block_given?
      img
    end
  end
end