require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get offers_home_url
    assert_response :success
  end

end
