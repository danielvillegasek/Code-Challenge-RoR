class SaleItem < ApplicationRecord
    self.table_name = "sale_item"
    belongs_to :product
    belongs_to :sale
end