class Message < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_one_attached :image

  validates :text, presence: true, unless: :was_attached?

  def was_attached?
    # コントローラーのimageを参照している（selfをつけることで参照可能)
    self.image.attached?
  end
end
