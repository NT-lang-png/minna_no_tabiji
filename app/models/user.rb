class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#バリデーション
  validates :handle_name, length: { minimum: 1, maximum: 20 }, presence:true
  validates :user_id, presence:true, uniqueness: true,  
    length: { minimum: 1, maximum: 20 }, format: { with: /\A[a-zA-Z0-9_-]+\z/,message: "は英数字、ハイフン、アンダースコアのみで入力してください" }
  validates :email, presence:true

#アソシエーション
  has_many :itineraries, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

#中間テーブル　アソシエーション
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  
  # フォローされているユーザーを取得
  has_many :followers, through: :passive_relationships, source: :follower

#フォロー機能メソッド
  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  #ゲストユーザー機能
  GUEST_USER_EMAIL = "guest@example.com"
 
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
  end
 
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  

  #ユーザー画像　なければno_image画像

  has_one_attached :image

  def get_image
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    else
      ActionController::Base.helpers.asset_path('no_image.jpg')
    end
  end
end
