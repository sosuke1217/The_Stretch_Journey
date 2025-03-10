class Genre < ApplicationRecord
  has_many :stretch_programs, dependent: :destroy
end
