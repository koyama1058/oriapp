class Message < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_one_attached :image

  with_options presence: true do
    validates :text
  end
end
