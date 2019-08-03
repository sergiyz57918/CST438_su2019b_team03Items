class Item < ApplicationRecord
    validates :price ,presence: true
    validates :stockQty,presence: true, numericality: { only_integer: true }
    validates :description,presence: true
    
    def validate (record)
        if !record.price>0
            record.errors[:base]<<'price must be greater than 0'
        end
        if record.stockQty<0
            record.errors[:base]<<'stockQty cannot be negative'
        end
    end
end
