require 'test_helper'

class AdminUserMailerTest < ActionMailer::TestCase

  setup do
    @book = books(:two)
  end

  test "should send book_approval email correctly" do
    mail = AdminUserMailer.book_approval(@book).deliver_now

    assert_equal 'noreply@teprestounlibro.com', mail['from'].to_s
    assert_equal AdminUser.pluck(:email).first, mail['to'].to_s
    assert_equal 'A new book needs your approval.', mail['subject'].value
  end
end
