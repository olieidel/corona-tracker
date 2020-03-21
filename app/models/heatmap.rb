class Heatmap < ApplicationRecord
  has_many :heatmap_values, inverse_of: :heatmap

  self.implicit_order_column = "created_at"

  def self.generate(radius_km:)
    data_starts_at = Rails.configuration.sliding_window.ago
    data_ends_at = DateTime.now

    heatmap = self.create(radius_km: radius_km,
                          data_starts_at: data_starts_at,
                          data_ends_at: data_ends_at)

    Questionnaire.sliding_window.each do |questionnaire|
      if percentage_sick = questionnaire.nearby_sick_percentage(radius_km: radius_km)
        HeatmapValue.create!(heatmap: heatmap,
                             latitude: questionnaire.latitude,
                             longitude: questionnaire.longitude,
                             percentage_sick: percentage_sick)
      end
    end

    heatmap
  end
end
