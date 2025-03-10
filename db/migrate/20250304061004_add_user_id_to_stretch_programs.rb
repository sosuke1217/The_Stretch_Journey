class AddUserIdToStretchPrograms < ActiveRecord::Migration[6.1]
  def change
    add_reference :stretch_programs, :user, null: false, foreign_key: true
  end
end
