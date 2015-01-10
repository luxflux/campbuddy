# encoding: utf-8

class AvatarUploader < ImageUploader
  version :small do # 350x350 non retina
    process resize_to_fit: [700, 700]
  end

  version :thumb do # 100x100 non retina
    process resize_to_fill: [200, 200]
  end
end
