class GenerateHeatmapJob < ApplicationJob
  queue_as :default

  def perform(simulated=false)
    Heatmap.generate(radius_km: 5, simulated: simulated)
  end
end
