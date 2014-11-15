class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :category
  has_many :attendances
  has_many :users, through: :attendances

  validates :owner, presence: true
  validates :category, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :starts_date, presence: true
  validates :starts_time, presence: true
  validates :ends_date, presence: true
  validates :ends_time, presence: true

  scope :on_date, ->(date) { where('DATE(starts) = ?', date) }
  scope :today, -> { on_date(Date.current) }
  scope :in_future, -> { where('starts > ?', Time.zone.now) }

  mount_uploader :impression, ImageUploader

  date_time_attribute :starts
  date_time_attribute :ends

  def attendance_places_left
    return nil unless max_attendees
    max_attendees - users.count
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
    attendances.first.mandatory
  end
end
