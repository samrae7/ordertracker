class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.string :product_name
      t.float :net_total
      t.float :gross_total

      t.timestamps null: false
    end
  end
end
