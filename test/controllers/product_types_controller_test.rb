require "test_helper"

class ProductTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_type = product_types(:one)
  end

  test "should get index" do
    get product_types_url, as: :json
    assert_response :success
  end

  test "should create product_type" do
    assert_difference("ProductType.count") do
      post product_types_url, params: { product_type: { description: @product_type.description } }, as: :json
    end

    assert_response :created
  end

  test "should show product_type" do
    get product_type_url(@product_type), as: :json
    assert_response :success
  end

  test "should update product_type" do
    patch product_type_url(@product_type), params: { product_type: { description: @product_type.description } }, as: :json
    assert_response :success
  end

  test "should destroy product_type" do
    assert_difference("ProductType.count", -1) do
      delete product_type_url(@product_type), as: :json
    end

    assert_response :no_content
  end
end
