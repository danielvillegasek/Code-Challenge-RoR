class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.integer :price, null: false, default: 0
      t.integer :provider_id, foreign_key: true
      t.timestamps
    end
  end
end
