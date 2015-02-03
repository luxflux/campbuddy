class Category < ActiveRecord::Base
  enum identifier: %i(red green blue gray yellow royal)

  default_scope ->{ order(:order) }

  has_many :events

  validates :identifier, presence: true
  validates :name, presence: true
end
