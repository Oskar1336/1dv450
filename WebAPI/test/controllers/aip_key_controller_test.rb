require 'test_helper'

class AipKeyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
