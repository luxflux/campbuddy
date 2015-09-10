class Group < ActiveRecord::Base
  default_scope ->{ order(:order) }

  validates :name, :leader, :order, presence: true

  belongs_to :leader, class_name: 'User'

  has_many :memberships
  has_many :users, through: :memberships

  has_many :group_attendances
  has_many :events, through: :group_attendances

  def name_with_leader
    if leader
      "#{name} (#{leader.name})"
    else
      name
    end
  end
end
