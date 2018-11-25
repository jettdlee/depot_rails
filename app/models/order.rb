class Order < ApplicationRecord
    PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
    has_many :line_items, dependent: :destroy
    validates :name, :address, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES

    enum pay_type: {
        "Check" => 0,
        "Credit card" => 1,
        "Purchase order" => 2,
        "Paypal" => 4 
    }

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
          item.cart_id = nil
          line_items << item  # add item to array
        end
      end

end
