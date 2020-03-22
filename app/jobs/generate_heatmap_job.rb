class GenerateHeatmapJob < ApplicationJob
  queue_as :default

  def perform(radius_km: Rails.configuration.default_heatmap_radius_km, simulated: false)
    Heatmap.generate(radius_km: radius_km, simulated: simulated)
  end
end
