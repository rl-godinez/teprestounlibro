require "application_system_test_case"

class AdminUsersTest < ApplicationSystemTestCase
  test "visiting the admin login" do
    visit new_admin_user_session_url
    assert_selector "label", text: "Email"
  end

  test "admin can login" do
    skip "Until carrierwave works"
    visit new_admin_user_session_url
    fill_in 'Email', with: 'admin@mail.com'
    fill_in 'Password', with: '111111'

    click_on 'Log in'

    assert_content 'Signed in successfully'
  end
end
