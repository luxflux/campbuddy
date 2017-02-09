# encoding: utf-8

class PicOfTheDayUploader < ImageUploader
  version :front do # 700x700 non retina
    process resize_to_fit: [700, 700]
  end
end
