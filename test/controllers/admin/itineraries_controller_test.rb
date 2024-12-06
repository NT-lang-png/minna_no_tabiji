require "test_helper"

class Admin::ItinerariesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_itineraries_show_url
    assert_response :success
  end
end
