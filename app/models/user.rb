class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :posts
  has_many :post_users
  has_many :posts, through: :post_users
  has_many :messages
  has_many :favorites, dependent: :destroy
  has_many :good_users
  has_many :bad_users

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :prefectures
  belongs_to_active_hash :job

  with_options presence: true do
  validates :nickname
  end

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end
end
