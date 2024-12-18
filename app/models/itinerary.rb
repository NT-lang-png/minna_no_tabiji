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

  #検索機能　タイトル検索
  def self.search_for(content)
    record_itineraries = Itinerary.where('title LIKE ?', '%' + content + '%')
  end

  #ブックマーク確認メソッド
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
