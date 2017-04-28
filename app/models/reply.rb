class Reply < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :favorites, class_name: 'FavoriteReply', dependent: :destroy

  validates :content, presence: true, length: { maximum: 200 }
end
