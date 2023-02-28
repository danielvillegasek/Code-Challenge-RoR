class CreateSaleItem < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_item do |t|
      t.integer :product_id, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :sale_id, foreign_key: true
    end
  end
end
