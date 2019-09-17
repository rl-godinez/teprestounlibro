require 'test_helper'
module Admin
  class BooksControllerTest < ActionDispatch::IntegrationTest
    setup do
      @book = books(:one)
      @admin = admin_users(:one)
      @user_without_books = users(:two)
    end

    test "admin can approve book" do
      sign_in @admin

      get approve_admin_book_url(@book)

      @book.reload

      assert @book.available?
    end
  end
end
