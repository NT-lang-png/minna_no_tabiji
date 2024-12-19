class Relationship < ApplicationRecord
  #中間テーブル　アソシエーション
  belongs_to :follower, class_name: "User" #フォローする人
  belongs_to :followed, class_name: "User" #フォローされる人
end
