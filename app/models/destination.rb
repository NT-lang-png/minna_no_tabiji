class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true


  attribute :day_number, :integer
  belongs_to :itinerary

  # before_validation :set_start_time

  private

  def set_start_time
    return if self.start_time.blank? || self.itinerary.start_time.blank?

    start_time = self.itinerary.start_time
    hour = self.start_time.hour
    min = self.start_time.min
    self.start_time = start_time.since(hour.hours).since(min.minutes).since(self.day_number.days)
  end
end
