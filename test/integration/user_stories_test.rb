require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  include ActiveJob::TestHelper

  test "buying a product" do
    start_order_count = Order.count
    ruby_book = products(:ruby)

    # in store page
    get "/"
    assert_response :success
    assert_select 'h1', "Your Pragmatic Catalog"

    # selects a product and adds to cart
    post '/line_items', params: {product_id: ruby_book.id}, xhr: true
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # Checks out
    get "/orders/new"
    assert_response :success
    assert_equal 'legend', 'Please Enter Your Details'

    perform_enqueue_jobs do

      #user fills form
      post "/orders", params: {
        order: {
          name: "Dave",
          address: "123 Ave"
          email: "jlee@yozu.co.uk"
          pay_type: "Check"
        }
      }

      follow_redirect!

      assert_response :success
      assert_select 'h1', "Your Pragmatic Catalog"
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.size

      # check order created in database
      assert_equal start_order_count + 1, Order.count
      order = Order.last

      assert_equal "Dave",  order.name
      assert_equal "123 Ave", order.address
      assert_equal "jlee@yozu.co.uk", order.email
      assert_equal "Check", order.pay_type

      assert_equal 1, order.line_items.size
      line_item = oorder.line_items[0]
      assert_equal ruby_book, line_item.product

      # verify mail is icorrectly addressed
      mail = ActionMailer::Base.deliveries.last
      assert_equal ["jlee@yozu.co.uk"], mail.to
      assert_equal 'jlee@yozu.co.uk', mail[:from].value
      assert_equal "Order Confirmation", mail.subject
    end
  end

end
