class HeatmapsController < ApplicationController
  # Serve the latest-generated heatmap.
  def show
    @heatmap = Heatmap.includes(:heatmap_values).order(created_at: :desc).first
  end
end
