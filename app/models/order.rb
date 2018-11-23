class Order < ApplicationRecord
    enum pay_type: {
        "Check" => 0,
        "Credit card" => 1,
        "Purchase order" => 2,
        "Paypal" => 4 
    }
end
