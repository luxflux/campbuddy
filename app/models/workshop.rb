class Workshop < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  has_many :attendances
  has_many :users, through: :attendances
end
