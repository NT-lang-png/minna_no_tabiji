class Destination < ApplicationRecord

  belongs_to :itinerary

  validates :day_number ,presence:true
  validates :start_time,presence:true
  validates :name,presence:true

end
