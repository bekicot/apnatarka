require 'test_helper'

class Admin::ChefMenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_chef_menus_index_url
    assert_response :success
  end

end
