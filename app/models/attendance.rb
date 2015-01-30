class Attendance < ActiveRecord::Base
  validates :user, presence: true
  validates :event, presence: true

  belongs_to :user, touch: true
  belongs_to :event, touch: true

  validates_uniqueness_of :user_id, scope: :event_id
  validates_presence_of :user_id, :event_id
end
