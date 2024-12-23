class Itinerary < ApplicationRecord

  belongs_to :user

  validates :title, presence:true, length: { minimum: 1, maximum: 20 }
  validates :region, presence:true
  validates :day_number, presence:true
  
  has_many :destinations, dependent: :destroy
  accepts_nested_attributes_for :destinations

  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  #ステータスの設定：公開中、下書き、非公開
  enum status: { published: 0, draft: 1, unpublished: 2 }

  # 行き先が1件以上あるしおりを取得するスコープ
  scope :with_destinations, -> { joins(:destinations).where(status: 'published').distinct }

  #地域別検索enum
  enum region: {
  undecided: 0,   # 未定
  hokkaido: 1,    # 北海道
  tohoku: 2,      # 東北
  kanto: 3,       # 関東
  hokuriku: 4,    # 北陸
  tokai: 5,       # 東海
  kansai: 6,      # 関西
  chugoku: 7,     # 中国
  shikoku: 8,     # 四国
  kyushu: 9,      # 九州
  okinawa: 10,    # 沖縄
  overseas: 11    # 海外
}

  #検索機能　タイトル検索
  def self.search_for(content)
    record_itineraries = Itinerary.where('title LIKE ?', '%' + content + '%')
  end

  def self.search_region_for(region)
    case region
    when region == ":hokkaido"
      record_itineraries = Itinerary.where(region: Itinerary.regions[:hokkaido])
    else
      Itinerary.none # もし条件に一致しなければ空の結果を返す
    end
  end

  #ブックマーク確認メソッド
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  #行き先を日付と時間順に並べるメソッド
  def ordered_destinations
    destinations.ordered
  end

  #キー画像　なければサンプル画像

  has_one_attached :key_image

  def get_key_image
    if key_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(key_image, only_path: true)
    else
      ActionController::Base.helpers.asset_path('key_image.jpg')
    end
  end

end
