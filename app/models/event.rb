class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :category
  has_many :attendances
  has_many :users, through: :attendances

  validate :owner, presence: true
  validate :category, presence: true
  validate :title, presence: true
  validate :description, presence: true
  validate :starts, presence: true
  validate :ends, presence: true

end
