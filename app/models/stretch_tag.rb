class StretchTag < ApplicationRecord
  has_many :stretch_program_tags, dependent: :destroy
  has_many :stretch_programs, through: :stretch_program_tags
  validates :name, presence: true, uniqueness: true
end
