require "test_helper"

class WishControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wish_index_url
    assert_response :success
  end

  test "should get new" do
    get wish_new_url
    assert_response :success
  end

  test "should get create" do
    get wish_create_url
    assert_response :success
  end

  test "should get destroy" do
    get wish_destroy_url
    assert_response :success
  end
end
