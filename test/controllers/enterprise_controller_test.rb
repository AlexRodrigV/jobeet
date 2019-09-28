require 'test_helper'

class EnterpriseControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get enterprise_home_url
    assert_response :success
  end

end
