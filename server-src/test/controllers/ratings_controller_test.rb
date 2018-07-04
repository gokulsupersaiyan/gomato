require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:one)
  end

  test "should get index" do
    get ratings_url, as: :json
    assert_response :success
  end

  test "should create rating" do
    assert_difference('Rating.count') do
      post ratings_url, params: { rating: { downvotes: @rating.downvotes, reply_from_hotel: @rating.reply_from_hotel, review: @rating.review, starts: @rating.starts, upvotes: @rating.upvotes } }, as: :json
    end

    assert_response 201
  end

  test "should show rating" do
    get rating_url(@rating), as: :json
    assert_response :success
  end

  test "should update rating" do
    patch rating_url(@rating), params: { rating: { downvotes: @rating.downvotes, reply_from_hotel: @rating.reply_from_hotel, review: @rating.review, starts: @rating.starts, upvotes: @rating.upvotes } }, as: :json
    assert_response 200
  end

  test "should destroy rating" do
    assert_difference('Rating.count', -1) do
      delete rating_url(@rating), as: :json
    end

    assert_response 204
  end
end
