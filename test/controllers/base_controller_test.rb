require 'test_helper'

class BaseControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get find_country" do
    get :find_country
    assert_response :success
  end

end
