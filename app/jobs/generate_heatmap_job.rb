class GenerateHeatmapJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Heatmap.generate(radius_km: 5)
  end
end
