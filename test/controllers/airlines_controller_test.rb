require "test_helper"

class AirlinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get airlines_index_url
    assert_response :success
  end

  test "should get show" do
    get airlines_show_url
    assert_response :success
  end
end
