class Group < ActiveRecord::Base
  validates :name, :leader, presence: true

  belongs_to :leader, class_name: 'User'

  has_many :memberships
  has_many :users, through: :memberships

  has_many :group_attendances
  has_many :events, through: :group_attendances

  def name_with_leader
    "#{name} (#{leader.name})"
  end
end
