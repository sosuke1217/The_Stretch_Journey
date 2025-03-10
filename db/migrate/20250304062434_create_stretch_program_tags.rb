class CreateStretchProgramTags < ActiveRecord::Migration[6.1]
  def change
    create_table :stretch_program_tags do |t|
      t.references :stretch_program, null: false, foreign_key: true
      t.references :stretch_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
