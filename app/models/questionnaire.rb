class Questionnaire < ApplicationRecord
  validates_presence_of :latitude, :longitude, :accuracy
  validates :healthy, :tested, :fever, :cough,
            inclusion: { in: [true, false] }
  validates_length_of :other_symptoms, minimum: 0, maximum: 255, allow_blank: true

  reverse_geocoded_by :latitude, :longitude

  self.implicit_order_column = "created_at"

  def self.sliding_window
    # Ordering could be not returning the newest entry per client in time window
    Rails.cache.fetch("questionnaires/sliding_window", expires_in: 5.minutes) do
      select("DISTINCT ON (client_uuid) client_uuid, *")
        .where("created_at > ?", Rails.configuration.sliding_window.ago)
        .order("client_uuid, created_at DESC")
    end
  end

  def nearby_sick_percentage(radius_km:)
    # Using .length because .count is currently broken due to the
    # distinct constraint in the sliding window
    sick = self.class.sliding_window
             .near([latitude, longitude], radius_km, units: :km)
             .where(healthy: false)
             .where.not(id: id)
             .length
    healthy = self.class.sliding_window
                .near([latitude, longitude], radius_km, units: :km)
                .where(healthy: true)
                .where.not(id: id)
                .length

    total = healthy + sick

    return nil if total == 0

    sick.to_f / total
  end
end
