class Event < ActiveRecord::Base
  YOUTUBE_REGEX = %r(\A(http[s]*:\/\/)?(www.)?(youtube.com|youtu.be)\/(watch\?v=){0,1}([a-zA-Z0-9_-]{11})\z)

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

  validates :youtube_url, format: YOUTUBE_REGEX, allow_blank: true

  validates_datetime :lock_at, on_or_before: :starts, allow_blank: true
  validates_date :starts, on_or_before: ->(event) { Setting.camp_ends }
  validates_date :starts, on_or_after: ->(event) { Setting.camp_starts }
  validates_date :ends, on_or_before: ->(event) { Setting.camp_ends }
  validates_date :ends, on_or_after: ->(event) { Setting.camp_starts }

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
  date_time_attribute :lock_at

  after_validation :copy_lock_at_errors
  after_validation :copy_starts_errors
  after_validation :copy_ends_errors

  def users
    return User.all if mandatory?
    User.where do
      id.in(my { self_attended_users }) |
        id.in(my { group_attendees }) |
        id.in(my { group_leader_attendees }) |
        id.in(my { owner })
    end
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
    "#{title} #{starts} #{teaser}"
  end

  def copy_lock_at_errors
    errors[:lock_at].each do |error|
      errors.add(:lock_at_time, error)
    end
  end

  def copy_starts_errors
    errors[:starts].each do |error|
      errors.add(:starts_date, error)
    end
  end

  def copy_ends_errors
    errors[:ends].each do |error|
      errors.add(:ends_date, error)
    end
  end

  def locked?
    lock_at && lock_at <= Time.zone.now
  end
end
