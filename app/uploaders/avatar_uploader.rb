# encoding: utf-8

class AvatarUploader < ImageUploader
  version :thumb do # 100x100 non retina
    process resize_to_fill: [200, 200]
  end
end
