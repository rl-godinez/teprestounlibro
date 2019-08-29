require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
    @admin = admin_users(:one)
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "creating a category" do
    sign_in @admin

    visit categories_url

    click_on "New category"

    fill_in 'Name', with: "Creating a new category"

    click_on "Create Category"

    assert_text "Category was successfully created"
  end

  test "can not create a category with name already taken" do
    sign_in @admin

    visit categories_url

    click_on "New category"

    fill_in 'Name', with: "comedy"

    click_on "Create Category"

    assert_text "Name has already been taken"
  end

  test "updating a category" do
    sign_in @admin

    visit edit_category_url(@category)

    fill_in "Name", with: "Updated name"

    click_on "Update Category"

    assert_text "Category successfully updated"
  end

  test "can not update a category with name already taken" do
    sign_in @admin

    visit edit_category_url(@category)

    fill_in "Name", with: "Comedy"

    click_on "Update Category"

    assert_text "Name has already been taken"
  end

  test "can not update a category" do
    sign_in @admin

    visit edit_category_url(@category)

    fill_in "Name", with: ""

    click_on "Update Category"

    assert_text "Name can't be blank"
  end

  test "destroying a category" do
    sign_in @admin

    visit categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Category was successfully destroyed"
  end

  test "only admin can create a category" do
    visit new_category_url

    assert has_current_path?(root_path)
  end

  test "only admin can update a category" do
    visit edit_category_url(@category)

    assert has_current_path?(root_path)
  end
end
