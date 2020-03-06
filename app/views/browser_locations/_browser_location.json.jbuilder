json.extract! browser_location, :id, :lonlat, :accuracy, :created_at, :updated_at
json.url browser_location_url(browser_location, format: :json)
