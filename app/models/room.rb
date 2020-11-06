class Room < ApplicationRecord

  belongs_to :post
  has_many :room_users
  has_many :users, through: :room_users, dependent: :destroy
  has_many :messages
end
