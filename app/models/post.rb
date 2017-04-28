class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :favorites, class_name: 'FavoritePost', dependent: :destroy
  scope :order_by_recent, -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 200 }

end
