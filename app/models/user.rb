class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :stretch_programs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :owner_groups, class_name: "Group", foreign_key: :owner_id
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_comments, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :active_users, -> { where(is_active: true) }
  scope :rejected_users, -> { where(is_active: false) }

  def deactivate
    update_attribute(:is_active, false)
  end

  def activate
    update_attribute(:is_active, true)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def is_approved?(group)
    self.group_users.approved.find_by(group: group)
  end

  def self.guest
    user = self.find_or_initialize_by(email: "guest@test.com")
    user.assign_attributes(
    password: SecureRandom.hex(6),
    name: "ゲスト"
    )
    user.save
    user
   end
end
