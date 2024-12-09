class Destination < ApplicationRecord
  attribute :day_number, :integer
  belongs_to :itinerary

  validates :day_number ,presence:true
  validates :start_time,presence:true
  validates :name,presence:true

  before_validation :set_start_time

  private

  def set_start_time
    start_time = self.itinerary.start_time
    hour = self.start_time.hour
    min = self.start_time.min
    self.start_time = start_time.since(hour.hours).since(min.minutes).since(self.day_number.days)
  end
end
