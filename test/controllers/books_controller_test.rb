require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @user = users(:one)
    @user_without_books = users(:two)
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
    sign_in @user

    assert_difference('Book.count') do
      post books_url, params: { book: { description: @book.description, name: @book.name, status: @book.status, category_ids: [Category.last.id] } }
    end

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

  test "user can borrow a book" do
    sign_in @user_without_books

    get assign_book_url(@book)

    @book.reload

    assert_equal @user_without_books, @book.secondary_user
  end
end
