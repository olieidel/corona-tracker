class Questionnaire < ApplicationRecord
  validates_presence_of :latitude, :longitude, :accuracy
  validates :healthy, :tested, :fever, :cough,
            inclusion: { in: [true, false] }
  validates_length_of :other_symptoms, minimum: 0, maximum: 255, allow_blank: true

  reverse_geocoded_by :latitude, :longitude

  self.implicit_order_column = "created_at"

  def self.sliding_window
    Rails.cache.fetch("questionnaires/sliding_window", expires_in: 5.minutes) do
      where("created_at > ?", Rails.configuration.sliding_window.ago)
    end
  end

  def nearby_sick_percentage(radius_km:)
    sick = self.class.sliding_window
             .near([latitude, longitude], radius_km, units: :km)
             .where(healthy: false)
             .where.not(id: id)
             .count(:all)
    healthy = self.class.sliding_window
                .near([latitude, longitude], radius_km, units: :km)
                .where(healthy: true)
                .where.not(id: id)
                .count(:all)

    total = healthy + sick

    return nil if total == 0

    sick.to_f / total
  end
end
