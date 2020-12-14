class AddTitleToBoard < ActiveRecord::Migration[6.0]
  def up
    add_column :boards, :title, :string
    change_column :boards, :title, :string, null: false
    add_column :boards, :board_type, :string
    change_column :boards, :board_type, :string, null: false
  end

  def down
    remove_column :boards, :title
    remove_column :boards, :type
  end
end
