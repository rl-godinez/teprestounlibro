require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the user login" do
    visit new_user_session_url
    assert_selector "label", text: "Email"
  end

  test "user can login" do
    skip "until carrierwave works"
    visit new_user_session_url
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: '111111'

    click_on 'Log in'

    assert_content 'Signed in successfully'
  end
end
