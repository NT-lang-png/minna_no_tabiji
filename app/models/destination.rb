class Destination < ApplicationRecord

  validates :day_number ,presence:true
  validates :start_time ,presence:true
  validates :name,presence:true , length: { minimum: 1, maximum: 30 }

  #しおりの日程の範囲内で行き先の日程を選ぶメソッド
  validate :day_number_within_itinerary_range


  #MAP
  geocoded_by :address
  after_validation :geocode, if: -> { address.present? && address_changed? }


  attribute :day_number, :integer
  belongs_to :itinerary


  #日程順、開始時間順に並び替えメソッド
  scope :ordered, -> { order(:day_number, :start_time) }

  #キー画像　なければサンプル画像

  has_one_attached :destination_image

  def get_destination_image
    if destination_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(destination_image, only_path: true)
    else
      ActionController::Base.helpers.asset_path('key_image.jpg')
    end
  end

  private

  def day_number_within_itinerary_range
  
    if day_number.nil?
      errors.add(:day_number, "を指定してください")
      return
    end

    if day_number < 1 || day_number > itinerary.day_number
      errors.add(:day_number, "はしおりの日程内で指定してください")
    end
  end


end
