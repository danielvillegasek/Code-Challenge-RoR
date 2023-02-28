class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :provider_id, presence: true

    has_many :sales
end