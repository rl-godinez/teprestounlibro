require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase

  setup do
    @book = books(:one)
    @user = users(:one)
    @user_without_books = users(:two)
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
    sign_in @user
    visit books_url
    assert_selector "h1", text: "There are 2 books waiting for you!"
  end

  test "creating a Book" do
    sign_in @user
    visit user_books_url(@user)
    click_on "Add a new book"

    page.refresh

    page.execute_script("document.getElementById('book_picture').style.opacity = 10")

    page.attach_file("#{Rails.root}/test/fixtures/files/image.jpg") do
      page.find(:xpath, "//*[@id='book_picture']").click
    end

    fill_in "Description", with: @book.description
    fill_in "Name", with: @book.name
    check "Comedy"
    click_on "Create Book"

    assert_text "Book was successfully created"
  end

  test "can not create a Book with empty params" do

    sign_in @user
    visit user_books_url(@user)
    click_on "Add a new book"

    fill_in "Description", with: ''
    fill_in "Name", with: ''
    click_on "Create Book"

    assert_text "Name can't be blank, Description can't be blank, Category ids can't be blank, and Picture can't be blank"
  end

  test "updating a Book" do
    sign_in @user
    visit user_books_url(@user)
    click_on "Edit", match: :first
    page.refresh
    fill_in "Description", with: @book.description
    fill_in "Name", with: @book.name
    check "Comedy"
    page.execute_script("document.getElementById('book_picture').style.opacity = 10")
    page.attach_file("#{Rails.root}/test/fixtures/files/image.jpg") do
      page.find(:xpath, "//*[@id='book_picture']").click
    end

    click_on "Update Book"

    assert_text "Book was successfully updated"
  end

  test "can not update a Book with empty params" do
    sign_in @user
    visit user_books_url(@user)
    click_on "Edit this book", match: :first

    fill_in "Description", with: ''
    fill_in "Name", with: ''
    click_on "Update Book"

    assert page.body.include?("Name can't be blank")
    assert page.body.include?("Description can't be blank")
  end

  test "destroying a Book" do
    sign_in @user
    visit user_books_url(@user)
    page.refresh
    page.accept_confirm do
      click_on "Delete this book", match: :first
    end

    assert_text "Book was successfully destroyed"
  end

  test "only book owner can destroy a Book" do
    sign_in @user_without_books

    visit books_url

    page.has_no_selector? 'a', text: 'Destroy'
  end

  test "only book owner can edit its books" do
    sign_in @user_without_books

    visit edit_book_path(@book)

    assert_content "Hey! you can't edit this book"

    assert has_current_path?(books_path)
  end

  test "user can change status from book" do
    sign_in @user

    book = Book.last
    book.available!
    book.reload
    visit book_url(book)

    old_status = book.status

    click_on book.not_available? ? "Available" : "Not available"

    assert has_current_path?(book_path(@book))

    @book.reload

    assert_not_equal old_status, @book.status
  end
end
