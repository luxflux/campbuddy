class CampAttendance < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :camp, touch: true

  validates :user, presence: true
  validates :camp, presence: true

  validates_uniqueness_of :user_id, scope: :camp_id
  validates_presence_of :user_id, :camp_id
end
