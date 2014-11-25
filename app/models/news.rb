class News < ActiveRecord::Base
  validates :message, presence: true
end
