class User < ApplicationRecord

  validates :nickname, presence: true

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :favorite_replies, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
