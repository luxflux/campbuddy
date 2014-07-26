class User < ActiveRecord::Base
  has_many :owned_workshops, class_name: 'Workshop', foreign_key: 'owner_id'
  has_many :leaded_groups,   class_name: 'Group',    foreign_key: 'leader_id'

  has_many :attendances
  has_many :workshops, through: :attendances

  has_many :memberships
  has_many :groups, through: :memberships

  validates :email, presence: true
  validates :name, presence: true
  validates :lastname, presence: true
  validates :password, presence: true
  validates :token, presence: true
end
