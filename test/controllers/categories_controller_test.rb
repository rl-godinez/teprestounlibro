require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should show the category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit category" do
    get edit_category_url(@category)
    assert_response :success
  end

  test 'should create a new category' do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'Programming' } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test 'should not create category with invalid params' do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: '' } }
    end

    assert_response :success
  end

  test 'should update category' do
    patch category_url(@category), params: { category: { name: 'Graphic novel' } }

    assert_redirected_to category_path(@category)

    @category.reload

    assert_equal "Graphic Novel", @category.name
  end

  test 'should not update category with invalid params' do
    patch category_url(@category), params: { category: { name: '' } }

    assert_response :success

    @category.reload

    assert_equal "Cience Fiction", @category.name
  end

  test 'should not update category with a category name existent' do
    patch category_url(@category), params: { category: { name: 'Comedy' } }

    assert_response :success

    @category.reload

    assert_equal "Cience Fiction", @category.name
  end

  test "should delete a cateogory" do
    assert_difference('Category.count', -1 ) do
      delete category_path(@category)
    end

    assert_redirected_to categories_path
  end
end
