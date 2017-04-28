class AddUniqueIndexToFavoritePosts < ActiveRecord::Migration[5.0]
  def change
    add_index :favorite_posts, [:user_id, :post_id], unique: true
  end
end
