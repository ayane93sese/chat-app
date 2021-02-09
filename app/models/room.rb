class Room < ApplicationRecord
  has_many :room_users
  has_many :users, thought: :room_users
end
