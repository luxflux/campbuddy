class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :category

  has_many :attendances
  has_many :self_attended_users, through: :attendances, source: :user

  has_many :group_attendances
  has_many :groups, through: :group_attendances

  has_many :group_attendees, through: :groups, source: :users
  has_many :group_leader_attendees, through: :groups, source: :leader

  validates :owner, presence: true
  validates :category, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :teaser, presence: true, length: { maximum: 50 }

  validates :starts, presence: true
  validates :starts_date, presence: true
  validates :starts_time, presence: true

  validates :ends, presence: true
  validates :ends_date, presence: true
  validates :ends_time, presence: true

  validates_date :starts, between: Setting.camp_start..Setting.camp_end
  validates_date :ends, between: Setting.camp_start..Setting.camp_end
  validates_datetime :starts, before: ->(event) { event.ends }
  validates_datetime :ends, after: ->(event) { event.starts }

  scope :on_date, ->(date) { where('DATE(starts) = ?', date) }
  scope :today, -> { on_date(Date.current) }
  scope :in_future, -> { where('starts > ?', Time.zone.now) }
  scope :mandatory, -> { joins(:category).where(categories: { mandatory_events: true }) }
  scope :without_mandatory, -> { joins(:category).where(categories: { mandatory_events: false }) }
  scope :without_group_events, -> { where(groups_only: false) }
  scope :info, -> { joins(:category).where(categories: { info_events: true }) }
  scope :without_info, -> { joins(:category).where(categories: { info_events: false }) }
  scope :group_events, -> { where(groups_only: true) }

  default_scope -> { order(:starts) }

  mount_uploader :impression, ImpressionUploader

  date_time_attribute :starts
  date_time_attribute :ends

  def users
    return User.all if mandatory?
    ids = [owner_id]
    ids.concat self_attended_user_ids
    ids.concat group_attendee_ids
    ids.concat group_leader_attendee_ids
    User.where(id: ids)
  end

  def attendance_places_left
    return nil unless max_attendees
    max_attendees - self_attended_users.count
  end

  def any_places_left?
    attendance_places_left.nil? || attendance_places_left > 0
  end

  def no_places_left?
    !any_places_left?
  end

  def attended_by_user?(user)
    users.include? user
  end

  def mandatory?
    category.mandatory_events?
  end

  def info_only?
    category.info_events?
  end

  def event_label
    #for admin
    "#{title} #{starts.to_datetime} #{teaser}"
  end
end
