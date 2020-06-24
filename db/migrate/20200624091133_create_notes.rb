class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :city, null: false
      t.integer :temperature
      t.text :note_text, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
