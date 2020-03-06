require "application_system_test_case"

class BrowserLocationsTest < ApplicationSystemTestCase
  setup do
    @browser_location = browser_locations(:one)
  end

  test "visiting the index" do
    visit browser_locations_url
    assert_selector "h1", text: "Browser Locations"
  end

  test "creating a Browser location" do
    visit browser_locations_url
    click_on "New Browser Location"

    fill_in "Accuracy", with: @browser_location.accuracy
    fill_in "Lonlat", with: @browser_location.lonlat
    click_on "Create Browser location"

    assert_text "Browser location was successfully created"
    click_on "Back"
  end

  test "updating a Browser location" do
    visit browser_locations_url
    click_on "Edit", match: :first

    fill_in "Accuracy", with: @browser_location.accuracy
    fill_in "Lonlat", with: @browser_location.lonlat
    click_on "Update Browser location"

    assert_text "Browser location was successfully updated"
    click_on "Back"
  end

  test "destroying a Browser location" do
    visit browser_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Browser location was successfully destroyed"
  end
end
