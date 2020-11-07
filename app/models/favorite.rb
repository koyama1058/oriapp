class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :post_id,  uniquness: { scope: [:post_id, :user_id]  }
end
