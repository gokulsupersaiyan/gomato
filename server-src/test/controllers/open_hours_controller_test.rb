require 'test_helper'

class OpenHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @open_hour = open_hours(:one)
  end

  test "should get index" do
    get open_hours_url, as: :json
    assert_response :success
  end

  test "should create open_hour" do
    assert_difference('OpenHour.count') do
      post open_hours_url, params: { open_hour: { from_hour_of_day: @open_hour.from_hour_of_day, from_week_day: @open_hour.from_week_day, to_hour_of_day: @open_hour.to_hour_of_day, to_week_day: @open_hour.to_week_day } }, as: :json
    end

    assert_response 201
  end

  test "should show open_hour" do
    get open_hour_url(@open_hour), as: :json
    assert_response :success
  end

  test "should update open_hour" do
    patch open_hour_url(@open_hour), params: { open_hour: { from_hour_of_day: @open_hour.from_hour_of_day, from_week_day: @open_hour.from_week_day, to_hour_of_day: @open_hour.to_hour_of_day, to_week_day: @open_hour.to_week_day } }, as: :json
    assert_response 200
  end

  test "should destroy open_hour" do
    assert_difference('OpenHour.count', -1) do
      delete open_hour_url(@open_hour), as: :json
    end

    assert_response 204
  end
end
