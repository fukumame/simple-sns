class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.integer :followed_user_id
      t.timestamps
    end
    add_index :follows, :followed_user_id
    add_foreign_key :follows, :users, column: :followed_user_id
  end
end
