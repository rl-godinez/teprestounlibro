require 'test_helper'
module Admin
  class CategoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @category = categories(:one)
      @user = users(:one)
      @admin = admin_users(:one)
    end

    test "should get index" do
      sign_in @admin
      get admin_categories_url
      assert_response :success
    end

    test "should get new" do
      sign_in @admin
      get new_admin_category_url
      assert_response :success
    end

    test "should show the category" do
      sign_in @admin
      get admin_category_url(@category)
      assert_response :success
    end

    test 'should not create category with invalid params' do
      sign_in @admin
      assert_no_difference('Category.count') do
        post admin_categories_url, params: { category: { name: '' } }
      end

      assert_response :success
    end

    test 'should not update category with invalid params' do
      sign_in @admin

      patch admin_category_url(@category), params: { category: { name: '' } }

      assert_response :success

      @category.reload

      assert_equal "Cience Fiction", @category.name
    end

    test 'should not update category with a category name existent' do
      sign_in @admin

      patch admin_category_url(@category), params: { category: { name: 'Comedy' } }

      assert_response :success

      @category.reload

      assert_equal "Cience Fiction", @category.name
    end


    test "admin should get edit category" do
      sign_in @admin
      get edit_admin_category_url(@category)
      assert_response :success
    end

    test 'admin should create a new category' do
      sign_in @admin

      assert_difference('Category.count') do
        post admin_categories_url, params: { category: { name: 'Programming' } }
      end

      assert_redirected_to admin_categories_url
    end

    test 'admin should update category' do
      sign_in @admin

      patch admin_category_url(@category), params: { category: { name: 'Graphic novel' } }

      assert_redirected_to admin_categories_url

      @category.reload

      assert_equal "Graphic Novel", @category.name
    end

    test "admin should delete a cateogory" do
      sign_in @admin

      assert_difference('Category.count', -1 ) do
        delete admin_category_path(@category)
      end

      assert_redirected_to admin_categories_path
    end
  end
end