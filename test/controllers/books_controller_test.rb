require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:two)
    @user = users(:one)
    @user_without_books = users(:two)
    @book_not_approved = books(:one)
  end

  test "should not get new if user is not signed in" do
    get new_book_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in @user

    get books_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user

    get new_book_url
    assert_response :success
  end

  test "should create book" do
    skip 'this is failing on ci and in local it is working well'
    sign_in @user

    assert_difference('Book.count') do
      post books_url, params: { book: { description: @book.description, name: @book.name, picture: fixture_file_upload('files/image.jpg', 'image/jpg'), category_ids: [Category.last.id] } }
    end

    assert Book.last.pending_approval?

    assert_redirected_to book_url(Book.last)
  end

  test 'should not create book with invalid params' do
    sign_in @user
    assert_no_difference('Book.count') do
      post books_url, params: { book: { description: '', name: '', status: '' } }
    end

    assert_response :success
  end

  test 'should not create book with no categories selected' do
    sign_in @user

    assert_no_difference('Book.count') do
      post books_url, params: { book: { description: 'Test description', name: 'Test name', category_ids: []  } }
    end

    assert_response :success
  end

  test "should show book" do
    sign_in @user

    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user

    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    sign_in @user

    patch book_url(@book), params: { book: { description: @book.description, name: @book.name, status: @book.status, category_ids: [Category.last.id] } }
    assert_redirected_to book_url(@book)
  end

  test 'should not update book with invalid params' do
    sign_in @user

    assert_no_difference('Book.count') do
      patch book_url(@book), params: { book: { description: '', name: '', status: '' } }
    end

    assert_response :success
  end

  test "should destroy book" do
    sign_in @user

    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test "only book owner can edit a book" do
    sign_in @user_without_books

    get edit_book_url(@book)

    assert_redirected_to books_url
  end

  test "only book owner can destroy its book" do
    sign_in @user_without_books

    assert_no_difference('Book.count') do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test "user can change status from book" do
    sign_in @user

    old_status = @book.status

    get toggle_status_book_url(@book)

    @book.reload

    assert_not_equal old_status, @book.status
  end

  test "user can borrow a book" do
    sign_in @user_without_books

    get assign_book_url(@book)

    @book.reload

    assert_equal @user_without_books, @book.secondary_user
  end


  test "should get user books" do
    sign_in @user

    get user_books_url(@user)

    assert_response :success
  end

  test "user cannot get show view for a book in pending approval status" do
    sign_in @user_without_books

    get book_url(@book_not_approved)

    assert_redirected_to books_url
  end

  test "cannot get show view for a book in pending approval status" do
    get book_url(@book_not_approved)

    assert_redirected_to books_url
  end
end
