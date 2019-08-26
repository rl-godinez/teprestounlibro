require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
  end
  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "creating a category" do
    visit categories_url

    click_on "New category"

    fill_in 'Name', with: "Creating a new category"

    click_on "Create Category"

    assert_text "Category was successfully created"
  end

  test "updating a category" do
    visit edit_category_url(@category)

    fill_in "Name", with: "Updated name"

    click_on "Update Category"

    assert_text "Category successfully updated"
  end
end
