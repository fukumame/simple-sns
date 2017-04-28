class CreateFavoriteReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_replies do |t|
      t.references :reply, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
