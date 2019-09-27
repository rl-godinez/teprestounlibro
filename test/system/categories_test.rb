require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
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

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Genres"
  end

  test "visiting the category" do
    visit category_url(@category)
    assert_content @category.name
    assert_content @category.books.first.name.titleize
  end
end
