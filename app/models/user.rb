class User < ActiveRecord::Base
  include Clearance::User

  has_many :owned_events,  class_name: 'Event', foreign_key: 'owner_id'
  has_many :leaded_groups, class_name: 'Group', foreign_key: 'leader_id'

  has_many :attendances
  has_many :events, through: :attendances

  has_many :memberships
  has_many :groups, through: :memberships

  validates :email, presence: true
  validates :firstname, presence: true
  validates :name, presence: true

  mount_uploader :avatar, ImageUploader

  before_create :generate_invitation_token

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

  def admin?
    !!admin
  end

  def user?
    !admin?
  end

  def guest?
    false
  end

  def fullname
    "#{firstname} #{name}"
  end

  def generate_invitation_token
    self.invitation_token ||= loop do
      token = SecureRandom.hex
      break token unless self.class.where(invitation_token: token).any?
    end
  end
end
