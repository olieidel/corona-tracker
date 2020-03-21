require 'test_helper'

class HeatmapsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get heatmaps_show_url
    assert_response :success
  end

end
