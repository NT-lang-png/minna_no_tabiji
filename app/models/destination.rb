class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true 
  validate :day_number_within_itinerary_range

  attribute :day_number, :integer
  belongs_to :itinerary

  # before_validation :set_start_time

  #日程順、開始時間順に並び替えメソッド
  scope :ordered, -> { order(:day_number, :start_time) }

  private


  def day_number_within_itinerary_range
    # itineraryのday_numberの範囲内かどうかを確認
    if day_number.present? && (day_number < 1 || day_number > itinerary.day_number)
      errors.add(:day_number, "はしおりの範囲内で選択してください")
    end
  end

  def set_start_time
    return if self.start_time.blank? || self.itinerary.start_time.blank?

    start_time = self.itinerary.start_time
    hour = self.start_time.hour
    min = self.start_time.min
    self.start_time = start_time.since(hour.hours).since(min.minutes).since(self.day_number.days)
  end
end
