class Map < ActiveRecord::Base
  default_scope -> { order(:order) }

  validates :name, presence: true
  validates :map, presence: true
  validates :order, presence: true

  mount_uploader :map, ImageUploader
end
