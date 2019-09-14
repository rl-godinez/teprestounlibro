require "application_system_test_case"
require 'tmpdir' # Not needed if you are using rails.

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @user = users(:one)
    @user_without_books = users(:two)
  end

  test "visiting the index" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit books_url
    assert_selector "h1", text: "There are 2 books waiting for you!"
  end

  test "creating a Book" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit books_url
    click_on "New Book"
    page.execute_script("$('#book_picture').css('opacity','1')")
    attach_file("book[picture]", "#{Rails.root}/test/fixtures/files/image.jpg")
    fill_in "Description", with: @book.description
    fill_in "Name", with: @book.name
    check "Comedy"
    click_on "Create Book"

    assert_text "Book was successfully created"
  end

  test "can not create a Book with empty params" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit books_url
    click_on "New Book"

    fill_in "Description", with: ''
    fill_in "Name", with: ''
    click_on "Create Book"

    assert_text "Name can't be blank, Description can't be blank, Category ids can't be blank, and Picture can't be blank"
  end

  test "updating a Book" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit books_url
    click_on "Edit", match: :first

    fill_in "Description", with: @book.description
    fill_in "Name", with: @book.name
    check "Comedy"
    click_on "Update Book"

    assert_text "Book was successfully updated"
  end

  test "can not update a Book with empty params" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit books_url
    click_on "Edit this book", match: :first

    fill_in "Description", with: ''
    fill_in "Name", with: ''
    click_on "Update Book"

    assert_text "Name can't be blank and Description can't be blank"
  end

  test "destroying a Book" do
    skip 'until fix carrierwave issue'
    skip 'failing in local'
    sign_in @user
    visit books_url
    page.accept_confirm do
      click_on "Delete this book", match: :first
    end

    assert_text "Book was successfully destroyed"
  end

  test "only book owner can destroy a Book" do
    skip 'until fix carrierwave issue'
    sign_in @user_without_books

    visit books_url

    page.has_no_selector? 'a', text: 'Destroy'
  end

  test "only book owner can edit its books" do
    skip 'until fix carrierwave issue'
    sign_in @user_without_books

    visit edit_book_path(@book)

    assert_content "Hey! you can't edit this book"

    assert has_current_path?(books_path)
  end

  test "user can change status from book" do
    skip 'until fix carrierwave issue'
    sign_in @user
    visit book_url(@book)

    old_status = @book.status

    click_on @book.not_available? ? "Available" : "Not available"

    assert has_current_path?(book_path(@book))
byebug
    @book.reload

    assert_not_equal old_status, @book.status
  end
end
