class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :uid, null: false
      t.text :profile

      t.timestamps
    end

    add_index :users, "LOWER(email)", unique: true
  end
end