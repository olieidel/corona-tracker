json.type "Feature"
json.geometry do
  json.type "Point"
  json.coordinates [questionnaire.browser_location.lonlat.lon, questionnaire.browser_location.lonlat.lat, 0]
end
json.properties do
  json.extract! questionnaire, :healthy, :fever, :cough, :created_at
  json.url questionnaire_url(questionnaire, format: :json)
end
