class User < ActiveRecord::Base
  include Clearance::User

  belongs_to :organization

  has_many :owned_events,  class_name: 'Event', foreign_key: 'owner_id'
  has_many :leaded_groups, class_name: 'Group', foreign_key: 'leader_id'

  has_many :attendances
  has_many :self_attended_events, through: :attendances, source: :event

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :group_events, through: :groups, source: :events
  has_many :leaded_group_events, through: :leaded_groups, source: :events

  validates :firstname, presence: true, unless: :guest?
  validates :name, presence: true, unless: :guest?
  validates :cellphone, phony_plausible: true, unless: :guest?

  mount_uploader :avatar, AvatarUploader

  after_save :send_welcome_mail, if: :send_mail

  scope :real_users, -> { where(guest: false) }
  scope :guests, -> { where(guest: true) }

  phony_normalize :cellphone, default_country_code: 'CH'

  attr_accessor :send_mail

  def events
    Event.where do
      id.in(my { self_attended_events }) |
        id.in(my { group_events }) |
        id.in(Event.without_group_events.mandatory) |
        id.in(my { leaded_group_events }) |
        id.in(my { owned_events })
    end
  end

  def all_groups
    Group.where do
      id.in(my { leaded_groups }) |
        id.in(my { groups })
    end
  end

  def user?
    !admin? && !guest?
  end

  def email_optional?
    guest?
  end

  def password_optional?
    guest?
  end

  def fullname
    "#{firstname} #{name}"
  end

  def generate_invitation_token
    update_column :invitation_token, User.invitation_token
  end

  def send_welcome_mail
    generate_invitation_token
    Notifications.welcome(self, Camp.current).deliver_now
  end

  def self.invitation_token
    loop do
      token = SecureRandom.hex
      break token unless where(invitation_token: token).any?
    end
  end

  def before_import_save(_csv_row)
    self.password ||= SecureRandom.hex
  end
end
