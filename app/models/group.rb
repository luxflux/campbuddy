class Group < ActiveRecord::Base
  belongs_to :leader, class_name: 'User'

  has_many :memberships
  has_many :users, through: :memberships
end
