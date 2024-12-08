class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :itineraries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #バリデーション
  validates :handle_name, length: { minimum: 1, maximum: 20 }, presence:true
  validates :user_id, presence:true, uniqueness: true,  length: { minimum: 1, maximum: 20 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は英数字のみで入力してください" }
  validates :email, presence:true
end
