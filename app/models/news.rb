class News < ActiveRecord::Base
  validates :message, presence: true
  validates :visible_until, presence: true

  validates_datetime :visible_until, after: ->{ Time.zone.now }

  scope :visible, -> { where('visible_until >= ?', Time.zone.now) }
end
