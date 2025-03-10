class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  scope :active_users_posts, -> { joins(:user).where('users.is_active' => true) }
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
