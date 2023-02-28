class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|      
      t.integer :client_id, foreign_key: true
      t.integer :total, default: 0
      t.timestamps
    end
  end
end
