require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "get terms_and_conditions" do
    get root_url
    assert_response :success
  end

end
