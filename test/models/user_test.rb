require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user valid" do
    user = User.new(email: 'test@mail.com',
                    password: 'p@ssword',
                    password_confirmation: 'p@ssword')

    assert user.valid?
  end
end
