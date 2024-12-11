class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true, format: { with: /\A[\p{Hiragana}\p{Katakana}\p{Han}ー]+\z/, message: '行き先は全角文字で入力してください' }


  attribute :day_number, :integer
  belongs_to :itinerary

  # before_validation :set_start_time

  #日程順、開始時間順に並び替えメソッド
  scope :ordered, -> { order(:day_number, :start_time) }

  private

  def set_start_time
    return if self.start_time.blank? || self.itinerary.start_time.blank?

    start_time = self.itinerary.start_time
    hour = self.start_time.hour
    min = self.start_time.min
    self.start_time = start_time.since(hour.hours).since(min.minutes).since(self.day_number.days)
  end
end
