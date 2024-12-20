require "test_helper"

class Public::ItinerariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_itineraries_new_url
    assert_response :success
  end

  test "should get index" do
    get public_itineraries_index_url
    assert_response :success
  end

  test "should get show" do
    get public_itineraries_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_itineraries_edit_url
    assert_response :success
  end
end
