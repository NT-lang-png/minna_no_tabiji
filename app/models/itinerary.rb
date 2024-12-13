class Itinerary < ApplicationRecord

  belongs_to :user

  validates :title, presence:true, length: { minimum: 1, maximum: 20 }
  validates :region, presence:true
  validates :day_number, presence:true
  
  has_many :destinations, dependent: :destroy
  accepts_nested_attributes_for :destinations

  # 行き先が1件以上あるしおりを取得するスコープ
  scope :with_destinations, -> { joins(:destinations).distinct }

end
