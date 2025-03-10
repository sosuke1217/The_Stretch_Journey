class AddTagNamesToStretchProgram < ActiveRecord::Migration[6.1]
  def change
    add_column :stretch_programs, :tag_names, :string
  end
end
