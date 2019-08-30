require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should show the category" do
    get category_url(@category)
    assert_response :success
  end
end
