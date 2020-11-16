class Post < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  has_many :messages
  has_many :post_users
  has_many :users, through: :post_users
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_one :spot

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :prefectures

  with_options presence: true do
    validates :image
    validates :title
    validates :category_id, numericality: { other_than: 1 }
    validates :description
    validates :day_time
    validates :prefectures_id
    validates :place
    validates :budget
  end
end
