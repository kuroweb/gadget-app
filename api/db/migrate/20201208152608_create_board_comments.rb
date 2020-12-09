class CreateBoardComments < ActiveRecord::Migration[6.0]
  def change
    create_table :board_comments do |t|
      t.references :board, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :description, null: false
      t.integer :reply_comment_id

      t.timestamps
    end
  end
end
