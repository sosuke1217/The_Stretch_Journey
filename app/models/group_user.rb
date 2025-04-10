class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  scope :approved, -> { where(is_approved: true) }
  scope :pending, -> { where(is_approved: false) }
end
