class AddIsApprovedToGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :is_approved, :boolean, default: false, null: false
  end
end
