class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :street, null: true
      t.timestamps
    end
  end
end
