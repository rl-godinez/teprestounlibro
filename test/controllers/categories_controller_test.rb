require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:one)
    @admin = admin_users(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "only admin should get new" do
    get new_category_url
    assert_redirected_to root_path
  end

  test "should show the category" do
    get category_url(@category)
    assert_response :success
  end

  test "only admin should get edit category" do
    get edit_category_url(@category)
    assert_redirected_to root_path
  end

  test 'only admin should create a new category' do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: 'Programming' } }
    end

    assert_redirected_to root_path
  end

  test 'should not create category with invalid params' do
    sign_in @admin
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: '' } }
    end

    assert_response :success
  end

  test 'only admin should update category' do
    patch category_url(@category), params: { category: { name: 'Graphic novel' } }

    assert_redirected_to root_path
  end

  test 'should not update category with invalid params' do
    sign_in @admin

    patch category_url(@category), params: { category: { name: '' } }

    assert_response :success

    @category.reload

    assert_equal "Cience Fiction", @category.name
  end

  test 'should not update category with a category name existent' do
    sign_in @admin

    patch category_url(@category), params: { category: { name: 'Comedy' } }

    assert_response :success

    @category.reload

    assert_equal "Cience Fiction", @category.name
  end

  test "only admin should delete a cateogory" do
    assert_no_difference('Category.count') do
      delete category_path(@category)
    end

    assert_redirected_to root_path
  end

  test "admin should get new" do
    sign_in @admin
    get new_category_url
    assert_response :success
  end

  test "admin should get edit category" do
    sign_in @admin
    get edit_category_url(@category)
    assert_response :success
  end

  test 'admin should create a new category' do
    sign_in @admin

    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'Programming' } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test 'admin should update category' do
    sign_in @admin

    patch category_url(@category), params: { category: { name: 'Graphic novel' } }

    assert_redirected_to category_path(@category)

    @category.reload

    assert_equal "Graphic Novel", @category.name
  end

  test "admin should delete a cateogory" do
    sign_in @admin

    assert_difference('Category.count', -1 ) do
      delete category_path(@category)
    end

    assert_redirected_to categories_path
  end
end
