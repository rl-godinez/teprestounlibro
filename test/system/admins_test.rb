require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  test "visiting the admin login" do
    visit new_admin_session_url
    assert_selector "label", text: "Email"
  end
end
