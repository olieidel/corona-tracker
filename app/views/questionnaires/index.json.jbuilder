json.cache! @questionnaires do
  json.type "FeatureCollection"
  json.features @questionnaires, partial: "questionnaires/questionnaire", as: :questionnaire
end
