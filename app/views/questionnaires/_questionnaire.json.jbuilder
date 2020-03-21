json.type "Feature"
json.geometry do
  json.type "Point"
  json.coordinates [questionnaire.longitude, questionnaire.latitude, 0]
end
json.properties do
  json.extract! questionnaire, :healthy, :tested, :fever, :cough, :other_symptoms, :created_at,
                :sick_percentage_in_5km_radius
  json.url questionnaire_url(questionnaire, format: :json)
end
