class User < ActiveRecord::Base
  include Clearance::User

  has_many :owned_events,  class_name: 'Event', foreign_key: 'owner_id'
  has_many :leaded_groups, class_name: 'Group', foreign_key: 'leader_id'

  has_many :attendances
  has_many :self_attended_events, through: :attendances, source: :event

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :group_events, through: :groups, source: :events
  has_many :leaded_group_events, through: :leaded_groups, source: :events

  validates :email, presence: true
  validates :firstname, presence: true
  validates :name, presence: true

  mount_uploader :avatar, ImageUploader

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      email = row.field('email')

      if email.include? "@"
        attributes = row.to_hash
        attributes[:password] = Kernel.rand

        unless User.where(:email => email).any?
          user = User.new(attributes)
          user.generate_invitation_token
          user.save!
        end
      end
    end
  end

  def events
    ids = []
    ids.concat self_attended_event_ids
    ids.concat Event.mandatory_only.ids
    ids.concat group_event_ids
    ids.concat leaded_group_events.ids
    ids.concat owned_event_ids
    Event.where(id: ids)
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
