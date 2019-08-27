require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test "Is a valid admin" do
    admin = Admin.new(email: 'new_admin@mail.com', password: "Pa$$word", password_confirmation: "Pa$$word")

    assert admin.save
  end

  test "is not a valid admin user" do
    admin = Admin.new()

    assert_not admin.save
  end

  test "email should be unique" do
    admin = Admin.new(email: 'admin@mail.com', password: "Pa$$word", password_confirmation: "Pa$$word")

    assert_not admin.save
    assert admin.errors.present?
  end
end
