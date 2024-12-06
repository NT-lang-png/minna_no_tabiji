require "test_helper"

class Public::MyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_my_index_url
    assert_response :success
  end
end
