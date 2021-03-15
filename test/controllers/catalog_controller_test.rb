require 'test_helper'

class CatalogControllerTest < ActionDispatch::IntegrationTest
  test "should render catalog" do
    get '/catalog'
    assert_response :success
  end
end
