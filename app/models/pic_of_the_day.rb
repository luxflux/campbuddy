class PicOfTheDay < ActiveRecord::Base
  mount_uploader :image, PicOfTheDayUploader
end
