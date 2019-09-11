require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "visiting the category" do
    visit category_url(@category)
    assert_content @category.name
    assert_content @category.books.first.name
  end
end
