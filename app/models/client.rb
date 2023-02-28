class Client < ApplicationRecord
    validates :name, presence: true


    has_many :sales

end