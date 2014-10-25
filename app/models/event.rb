class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :category
  has_many :attendances
  has_many :users, through: :attendances

  validates :owner, presence: true
  validates :category, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :starts, presence: true
  validates :ends, presence: true

  scope :on_date, ->(date) { where('DATE(starts) = ?', date) }
  scope :today, -> { on_date(Date.current) }

  mount_uploader :impression, ImageUploader
end
