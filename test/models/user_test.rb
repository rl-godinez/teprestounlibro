require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "user valid" do
    user = User.new(email: 'test@mail.com',
                    password: 'p@ssword',
                    password_confirmation: 'p@ssword')

    assert user.valid?
    assert user.save
  end

  test 'invalid user' do
    user = User.new()

    assert_not user.valid?
    assert_not user.save
  end

  test 'user can not register with an email already registered' do
    user = User.new(email: 'user1@mail.com',
                    password: 'p@ssword',
                    password_confirmation: 'p@ssword')

    assert_not user.valid?
    assert_not user.save
  end

  test '#books' do
    assert_equal 3, @user.books.size
  end

  test '#books after destroying user' do
    user_id = @user.id
    @user.destroy

    assert_equal 0, Book.where(user_id: user_id).size
  end
end
