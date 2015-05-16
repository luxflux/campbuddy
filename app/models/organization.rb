class Organization < ActiveRecord::Base
  has_many :camps
  has_many :users

  validates :name, presence: true
  validates :domain, presence: true
end
