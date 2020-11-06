class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_one_attached :image

  with_options presence: true do
    validates :text
  end
end
