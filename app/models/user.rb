class User < ApplicationRecord

  validates :nickname, presence: true

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :favorite_replies, dependent: :destroy
  has_many :favorite_posts, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :all_followees, through: :follows, source: :followed_user
  has_many :follows_from_follower, dependent: :destroy, foreign_key: :followed_user_id, class_name: 'Follow'
  has_many :all_followers, through: :follows_from_follower, source: :user

  before_create do |user|
    follow_myself(user)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :others, -> (user_id) { where('id <> ?', user_id) }

  def others
    User.others(id)
  end

  def already_followed?(user)
    all_followees.find_by(id: user.id).present?
  end

  def already_favorite_post?(post)
    favorite_posts.where(post_id: post.id).present?
  end

  def already_favorite_reply?(reply)
    favorite_replies.where(reply_id: reply.id).present?
  end

  def posts_in_feeds
    followed_user_id = all_followees.collect(&:id)
    Post.where(user_id: followed_user_id).order_by_recent
  end

  def followers
    all_followers.where('users.id <> ?', id)
  end

  def followees
    all_followees.where('users.id <> ?', id)
  end

  private

  def follow_myself(user)
    user.follows.build(followed_user: user)
  end
end
