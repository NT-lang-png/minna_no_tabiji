class Itinerary < ApplicationRecord

  belongs_to :user

  validates :title, presence:true
  validates :region, presence:true

end
