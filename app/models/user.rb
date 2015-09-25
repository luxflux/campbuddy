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
  validates :birthday, presence: true, unless: :guest?
  validates :cellphone, presence: true, phony_plausible: true, unless: :guest?

  mount_uploader :avatar, AvatarUploader

  after_save :invite, if: :send_mail

  scope :real_users, -> { where(guest: false) }
  scope :guests, -> { where(guest: true) }

  phony_normalize :cellphone, default_country_code: 'CH'

  attr_accessor :send_mail

  def events
    ids = []
    ids.concat self_attended_event_ids
    ids.concat Event.without_group_events.mandatory.ids
    ids.concat group_event_ids
    ids.concat leaded_group_events.ids
    ids.concat owned_event_ids
    Event.where(id: ids)
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

  def invite
    update_column :invitation_token, User.invitation_token
    Notifications.invitation(self, Camp.current).deliver_now
  end

  def self.invitation_token
    loop do
      token = SecureRandom.hex
      break token unless where(invitation_token: token).any?
    end
  end
end
