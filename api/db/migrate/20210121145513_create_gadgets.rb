class CreateGadgets < ActiveRecord::Migration[6.0]
  def change
    create_table :gadgets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :good_description, null: false
      t.text :bad_description, null: false
      t.integer :stars, null: false

      t.timestamps
    end
  end
end
