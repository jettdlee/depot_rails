module CurrentCart
    extend ActiveSupport::Concern

    private

    def set_cart
        @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        @cart = Cart.create
        session[:card_id]=@card.card_id
    end
end
