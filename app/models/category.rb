class Category < ActiveRecord::Base
  enum identifier: %i(red green blue gray yellow royal)
  has_many :events

  validates :identifier, presence: true
  validates :name, presence: true
end
