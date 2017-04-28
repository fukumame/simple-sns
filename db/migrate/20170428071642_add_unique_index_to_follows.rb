class AddUniqueIndexToFollows < ActiveRecord::Migration[5.0]
  def change
    add_index :follows, [:user_id, :followed_user_id], unique: true
  end
end
