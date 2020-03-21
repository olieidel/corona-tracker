json.type "Feature"
json.geometry do
  json.type "Point"
  json.coordinates [questionnaire.longitude, questionnaire.latitude, 0]
end
json.properties do
  json.extract! questionnaire, :healthy, :tested, :fever, :cough
end
