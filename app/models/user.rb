class User < ActiveRecord::Base
  include Clearance::User

  has_many :owned_workshops, class_name: 'Workshop', foreign_key: 'owner_id'
  has_many :leaded_groups,   class_name: 'Group',    foreign_key: 'leader_id'

  has_many :attendances
  has_many :workshops, through: :attendances

  has_many :memberships
  has_many :groups, through: :memberships

  validates :email, presence: true
  validates :firstname, presence: true
  validates :name, presence: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      email = row.field('email')

      if email.include? "@"
        attributes = row.to_hash
        attributes[:password] = Kernel.rand
        User.where(:email => email).first_or_create!(attributes)
      end
    end
  end

end
