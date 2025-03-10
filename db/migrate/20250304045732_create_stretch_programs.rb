class CreateStretchPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :stretch_programs do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.integer :difficulty
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
