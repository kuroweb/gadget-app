class CreateGadgetTagMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :gadget_tag_maps do |t|
      t.references :gadget, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
