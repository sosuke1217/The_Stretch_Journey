class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :members, through: :group_users, source: :user
  has_many :group_comments, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true

  def is_owned_by?(user)
    owner.id == user.id
  end
end
