class AddColumnUsersGuest < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :guest, :boolean, null: false, default: false
  end

  def down
    remove_column :users, :guest, :boolean, null: false, default: false
  end
end
