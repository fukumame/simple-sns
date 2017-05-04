class FavoriteReply < ApplicationRecord
  belongs_to :reply
  belongs_to :user
  validates :reply_id, uniqueness: { scope: :user_id }
end
