class RenameFavotitesToBookmark < ActiveRecord::Migration[6.1]
  def change
    rename_table :favotites, :bookmarks
  end
end
