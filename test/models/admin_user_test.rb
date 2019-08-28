require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  test "Is a valid admin" do
    admin = AdminUser.new(email: 'new_admin@mail.com', password: "Pa$$word", password_confirmation: "Pa$$word")

    assert admin.save
  end

  test "is not a valid admin user" do
    admin = AdminUser.new()

    assert_not admin.save
  end

  test "email should be unique" do
    admin = AdminUser.new(email: 'admin@mail.com', password: "Pa$$word", password_confirmation: "Pa$$word")

    assert_not admin.save
    assert admin.errors.present?
  end
end
