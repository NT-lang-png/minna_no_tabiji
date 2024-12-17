class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :itineraries, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #バリデーション
  validates :handle_name, length: { minimum: 1, maximum: 20 }, presence:true
  validates :user_id, presence:true, uniqueness: true,  
    length: { minimum: 1, maximum: 20 }, format: { with: /\A[a-zA-Z0-9_-]+\z/,message: "は英数字、ハイフン、アンダースコアのみで入力してください" }
  validates :email, presence:true
  

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
