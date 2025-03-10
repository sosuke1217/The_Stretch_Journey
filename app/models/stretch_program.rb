class StretchProgram < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :stretch_program_tags, dependent: :destroy
  has_many :stretch_tags, through: :stretch_program_tags
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :difficulty, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :genre_id, presence: true

  def tag_names
    stretch_tags.pluck(:name).join(',')
  end

  def tag_names=(names)
    self.stretch_tags = names.split(',').map do |name|
      StretchTag.find_or_create_by(name: name.strip)
    end
  end
end
