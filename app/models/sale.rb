class Sale < ApplicationRecord
    validates :client_id, presence: true
    validates :total, presence: true

    has_many :item_sales, foreign_key: :sale_id, class_name: "ItemSale"
    belongs_to :client
end