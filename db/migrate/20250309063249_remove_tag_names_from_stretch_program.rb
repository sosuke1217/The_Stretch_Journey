class RemoveTagNamesFromStretchProgram < ActiveRecord::Migration[6.1]
  def change
    remove_column :stretch_programs, :tag_names, :string
  end
end
