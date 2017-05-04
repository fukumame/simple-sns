class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: 'User', foreign_key: 'followed_user_id'
  validates :followed_user_id, uniqueness: { scope: :user_id }
end
