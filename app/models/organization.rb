class Organization < ActiveRecord::Base
  has_many :camps

  validates :name, presence: true
  validates :domain, presence: true
end
