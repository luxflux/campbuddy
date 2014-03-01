class User < ActiveRecord::Base
  has_many :owned_workshops, class_name: 'Workshop', foreign_key: 'owner_id'
end
