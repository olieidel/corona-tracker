require 'test_helper'

class BrowserLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @browser_location = browser_locations(:one)
  end

  test "should get index" do
    get browser_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_browser_location_url
    assert_response :success
  end

  test "should create browser_location" do
    assert_difference('BrowserLocation.count') do
      post browser_locations_url, params: { browser_location: { accuracy: @browser_location.accuracy, lonlat: @browser_location.lonlat } }
    end

    assert_redirected_to browser_location_url(BrowserLocation.last)
  end

  test "should show browser_location" do
    get browser_location_url(@browser_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_browser_location_url(@browser_location)
    assert_response :success
  end

  test "should update browser_location" do
    patch browser_location_url(@browser_location), params: { browser_location: { accuracy: @browser_location.accuracy, lonlat: @browser_location.lonlat } }
    assert_redirected_to browser_location_url(@browser_location)
  end

  test "should destroy browser_location" do
    assert_difference('BrowserLocation.count', -1) do
      delete browser_location_url(@browser_location)
    end

    assert_redirected_to browser_locations_url
  end
end
