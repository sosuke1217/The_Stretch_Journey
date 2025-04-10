class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, presence: true
  
  def self.looks(search, word)
    if search == "perfect_match"
      where("comment LIKE ?", "#{word}")
    elsif search == "forward_match"
      where("comment LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("comment LIKE ?", "%#{word}")
    elsif search == "partial_match"
      where("comment LIKE ?", "%#{word}%")
    else
      all
    end
  end
end
