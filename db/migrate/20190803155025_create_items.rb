class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text "description", null: false
      t.decimal "price", precision: 5, scale: 2, default: "0.1"
      t.integer "stockQty", precision: 5, scale: 2, default: "0"
      t.timestamps
    end
  end
end
