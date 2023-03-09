require "test_helper"

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delivery = deliveries(:one)
  end

  test "should get index" do
    get deliveries_url, as: :json
    assert_response :success
  end

  test "should create delivery" do
    assert_difference("Delivery.count") do
      post deliveries_url, params: { delivery: { product_id: @delivery.product_id, product_type_id: @delivery.product_type_id, travel_id: @delivery.travel_id } }, as: :json
    end

    assert_response :created
  end

  test "should show delivery" do
    get delivery_url(@delivery), as: :json
    assert_response :success
  end

  test "should update delivery" do
    patch delivery_url(@delivery), params: { delivery: { product_id: @delivery.product_id, product_type_id: @delivery.product_type_id, travel_id: @delivery.travel_id } }, as: :json
    assert_response :success
  end

  test "should destroy delivery" do
    assert_difference("Delivery.count", -1) do
      delete delivery_url(@delivery), as: :json
    end

    assert_response :no_content
  end
end
