class Spot < ApplicationRecord

  belongs_to :post

  geocoded_by :address
  before_validation :geocode
end
