class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         extend ActiveHash::Associations::ActiveRecordExtensions
         belongs_to_active_hash :gender
         belongs_to_active_hash :prefectures
         belongs_to_active_hash :job

         with_options presence: true do
          validates :nickname
        end
end
