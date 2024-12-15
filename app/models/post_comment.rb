class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :itinerary

  validates :comment,presence:true
  
end
