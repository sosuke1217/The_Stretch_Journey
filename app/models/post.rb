class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
