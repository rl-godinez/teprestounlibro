require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should  be able to save a Category" do
    category = Category.new(name: 'Technology')
    assert category.save
  end

  test "should not be able to save a Category without name" do
    category = Category.new
    assert_not category.save
  end

  test "should not be able to save a Category with an existing category name" do
    category = Category.new(name: 'Cience Fiction')
    assert_not category.save
  end

  test "should not be able to save a Category with an existing category name and empty spaces" do
    category = Category.new(name: '   Cience Fiction        ')
    assert_not category.save
  end
end
