class CreatePostTagMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tag_maps do |t|
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
