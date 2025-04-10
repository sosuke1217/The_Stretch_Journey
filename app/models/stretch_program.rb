class StretchProgram < ApplicationRecord
  attr_accessor :tag_names
  
  belongs_to :user
  belongs_to :genre
  has_many :stretch_program_tags, dependent: :destroy
  has_many :stretch_tags, through: :stretch_program_tags
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :difficulty, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :genre_id, presence: true

  after_save :create_tags
  after_update :not_used_stretch_tags_destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @stretch_program = StretchProgram.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @stretch_program = StretchProgram.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @stretch_program = StretchProgram.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @stretch_program = StretchProgram.where("title LIKE?","%#{word}%")
    else
      @stretch_program = StretchProgram.all
    end
  end

  private

  def create_tags
    new_tag_names = self.tag_names
    if new_tag_names.present?
      new_tag_names.split(',').map{ |o| o.gsub(/[[:space:]]/, "") }.each do |name|
        tag = StretchTag.find_or_create_by(name: name)
        self.stretch_tags << tag
      end
    end
  end

  def not_used_stretch_tags_destroy
    StretchTag.where.missing(:stretch_program_tags).destroy_all
  end
end
