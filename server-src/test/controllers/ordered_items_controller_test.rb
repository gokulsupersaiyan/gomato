require 'test_helper'

class OrderedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ordered_item = ordered_items(:one)
  end

  test "should get index" do
    get ordered_items_url, as: :json
    assert_response :success
  end

  test "should create ordered_item" do
    assert_difference('OrderedItem.count') do
      post ordered_items_url, params: { ordered_item: { quantity: @ordered_item.quantity } }, as: :json
    end

    assert_response 201
  end

  test "should show ordered_item" do
    get ordered_item_url(@ordered_item), as: :json
    assert_response :success
  end

  test "should update ordered_item" do
    patch ordered_item_url(@ordered_item), params: { ordered_item: { quantity: @ordered_item.quantity } }, as: :json
    assert_response 200
  end

  test "should destroy ordered_item" do
    assert_difference('OrderedItem.count', -1) do
      delete ordered_item_url(@ordered_item), as: :json
    end

    assert_response 204
  end
end
