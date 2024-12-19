class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true 

  #MAP
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  validate :day_number_within_itinerary_range #しおりの日程の範囲内で行き先の日程を選ぶメソッド

  attribute :day_number, :integer
  belongs_to :itinerary


  #日程順、開始時間順に並び替えメソッド
  scope :ordered, -> { order(:day_number, :start_time) }

  private

  def day_number_within_itinerary_range
    # itineraryのday_numberの範囲内かどうかを確認
    if day_number.present? && (day_number < 1 || day_number > itinerary.day_number)
      errors.add(:day_number, "はしおりの範囲内で選択してください")
    end
  end

end
