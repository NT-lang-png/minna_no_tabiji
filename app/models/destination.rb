class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true , length: { minimum: 1, maximum: 30 }

  #しおりの日程の範囲内で行き先の日程を選ぶメソッド
  validate :day_number_within_itinerary_range


  #MAP
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  attribute :day_number, :integer
  belongs_to :itinerary


  #日程順、開始時間順に並び替えメソッド
  scope :ordered, -> { order(:day_number, :start_time) }

  private

  def day_number_within_itinerary_range
    if day_number < 1 || day_number > itinerary.day_number
      errors.add(:day_number, "はしおりの日程内で指定してください")
    end
  end


end
