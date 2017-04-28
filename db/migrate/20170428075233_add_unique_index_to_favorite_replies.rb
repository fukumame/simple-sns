class AddUniqueIndexToFavoriteReplies < ActiveRecord::Migration[5.0]
  def change
    add_index :favorite_replies, [:user_id, :reply_id], unique: true
  end
end
