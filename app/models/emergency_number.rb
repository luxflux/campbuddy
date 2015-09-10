class EmergencyNumber < ActiveRecord::Base
  enum color: %i(black red green blue gray yellow royal)

  default_scope ->{ order(:order) }

  validates :name, presence: true
  validates :number, presence: true
  validates :color, presence: true
  validates :order, presence: true
end
