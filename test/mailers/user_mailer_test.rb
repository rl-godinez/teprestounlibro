require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  setup do
    @book = books(:two)
    @user_without_books = users(:two)
  end

  test "should send borrowed_book email correctly" do
    @book.update(secondary_user_id: @user_without_books.id)
    mail = UserMailer.borrowed_book(@book).deliver_now

    assert_equal 'noreply@teprestounlibro.com', mail['from'].to_s

    assert_equal @book.user.email, mail['to'].to_s

    assert_equal 'Somebody wants to read your book!', mail['subject'].value
  end

  test "should send approved_book email correctly" do
    mail = UserMailer.approved_book(@book).deliver_now

    assert_equal 'noreply@teprestounlibro.com', mail['from'].to_s

    assert_equal @book.user.email, mail['to'].to_s

    assert_equal 'Your book has been approved!', mail['subject'].value
  end
end
