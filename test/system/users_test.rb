require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    PictureUploader.enable_processing = true
    CarrierWave.root = Rails.root.join('public')
    file_path = File.join( fixture_path, "files", "image.jpg")
    data_url  = "data:image/jpeg;base64,"
    data_url += Base64.encode64(File.open(file_path).read)
    book = Book.create(name: 'test', description: 'test', user_id: @user.id, picture: data_url)
    @uploader = PictureUploader.new(book, :picture)
    File.open(file_path) { |f| @uploader.store!(f) }
  end
  test "visiting the user login" do
    visit new_user_session_url
    assert_selector "label", text: "Email"
  end

  test "user can login" do
    visit new_user_session_url
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: '111111'

    click_on 'Log in'

    assert_content 'Signed in successfully'
  end
end
