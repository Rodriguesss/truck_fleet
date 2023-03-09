require "test_helper"

class TruckDriversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @truck_driver = truck_drivers(:one)
  end

  test "should get index" do
    get truck_drivers_url, as: :json
    assert_response :success
  end

  test "should create truck_driver" do
    assert_difference("TruckDriver.count") do
      post truck_drivers_url, params: { truck_driver: { age: @truck_driver.age, name: @truck_driver.name } }, as: :json
    end

    assert_response :created
  end

  test "should show truck_driver" do
    get truck_driver_url(@truck_driver), as: :json
    assert_response :success
  end

  test "should update truck_driver" do
    patch truck_driver_url(@truck_driver), params: { truck_driver: { age: @truck_driver.age, name: @truck_driver.name } }, as: :json
    assert_response :success
  end

  test "should destroy truck_driver" do
    assert_difference("TruckDriver.count", -1) do
      delete truck_driver_url(@truck_driver), as: :json
    end

    assert_response :no_content
  end
end
