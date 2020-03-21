json.type "Feature"
json.geometry do
  json.type "Point"
  json.coordinates [heatmap_value.longitude, heatmap_value.latitude, 0]
end
json.properties do
  json.extract! heatmap_value, :percentage_sick
end
