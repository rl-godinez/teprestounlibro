require "application_system_test_case"
module Admin
  class CategoriesTest < ApplicationSystemTestCase
    setup do
      @category = categories(:one)
      @admin = admin_users(:one)
    end

    test "visiting the index" do
      sign_in @admin
      visit admin_categories_url
      assert_selector "h1", text: "Categories"
    end

    test "updating a category" do
      sign_in @admin
      visit admin_categories_url
      click_on "Edit", match: :first
      fill_in "Name", with: 'Updated name'
      click_on 'Update Category'

      assert_content "Category was successfully updated."
    end

    test "not able to update a category" do
      sign_in @admin
      visit admin_categories_url
      click_on "Edit", match: :first
      fill_in "Name", with: ''
      click_on 'Update Category'

      assert_content "Name can't be blank"
    end

    test "create a category" do
      sign_in @admin
      visit admin_categories_url
      click_on 'New category'

      fill_in "Name", with: 'New category'

      click_on 'Create Category'

      assert_content "Category was successfully created"
    end

    test "not able to create a category" do
      sign_in @admin
      visit admin_categories_url
      click_on 'New category'

      fill_in "Name", with: ''

      click_on 'Create Category'

      assert_content "Name can't be blank"
    end

    test "deleting a category" do
      sign_in @admin
      visit admin_categories_url

      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_content "Category was successfully destroyed"
    end
  end
end