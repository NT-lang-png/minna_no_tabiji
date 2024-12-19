class AddIndexesToRelationships < ActiveRecord::Migration[6.1]
  def change
    #relationshipモデルにindexと 相互フォロー関係にuniqueを追加
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
