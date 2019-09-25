require 'test_helper'
module AdminUsers
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    setup do
      @admin = admin_users(:one)
    end

    test "admin can login" do
      post admin_user_session_url(email: @admin, password: '111111')

      assert_response :success
    end
  end
end