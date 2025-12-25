require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get games_start_url
    assert_response :success
  end
end
