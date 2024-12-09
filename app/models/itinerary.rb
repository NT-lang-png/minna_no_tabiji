class Itinerary < ApplicationRecord

  belongs_to :user

  validates :title, presence:true
  validates :region, presence:true
  has_many :destinations, dependent: :destroy
  accepts_nested_attributes_for :destinations
end
