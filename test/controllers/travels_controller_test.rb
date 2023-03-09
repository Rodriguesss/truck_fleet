require "test_helper"

class TravelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @travel = travels(:one)
  end

  test "should get index" do
    get travels_url, as: :json
    assert_response :success
  end

  test "should create travel" do
    assert_difference("Travel.count") do
      post travels_url, params: { travel: { date_of_origin: @travel.date_of_origin, destination_date: @travel.destination_date, expected_date: @travel.expected_date } }, as: :json
    end

    assert_response :created
  end

  test "should show travel" do
    get travel_url(@travel), as: :json
    assert_response :success
  end

  test "should update travel" do
    patch travel_url(@travel), params: { travel: { date_of_origin: @travel.date_of_origin, destination_date: @travel.destination_date, expected_date: @travel.expected_date } }, as: :json
    assert_response :success
  end

  test "should destroy travel" do
    assert_difference("Travel.count", -1) do
      delete travel_url(@travel), as: :json
    end

    assert_response :no_content
  end
end
