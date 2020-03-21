json.cache! heatmap do
  json.type "FeatureCollection"
  json.properties do
    json.extract! heatmap, :radius_km, :data_starts_at, :data_ends_at
  end
  json.features heatmap.heatmap_values, partial: "heatmap_values/heatmap_value", as: :heatmap_value
end
