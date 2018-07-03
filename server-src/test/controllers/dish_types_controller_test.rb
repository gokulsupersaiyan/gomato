require 'test_helper'

class DishTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dish_type = dish_types(:one)
  end

  test "should get index" do
    get dish_types_url, as: :json
    assert_response :success
  end

  test "should create dish_type" do
    assert_difference('DishType.count') do
      post dish_types_url, params: { dish_type: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show dish_type" do
    get dish_type_url(@dish_type), as: :json
    assert_response :success
  end

  test "should update dish_type" do
    patch dish_type_url(@dish_type), params: { dish_type: {  } }, as: :json
    assert_response 200
  end

  test "should destroy dish_type" do
    assert_difference('DishType.count', -1) do
      delete dish_type_url(@dish_type), as: :json
    end

    assert_response 204
  end
end
