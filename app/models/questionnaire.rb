class Questionnaire < ApplicationRecord
  validates_presence_of :latitude, :longitude, :accuracy
  validates :healthy, :tested, :fever, :cough,
            inclusion: { in: [true, false] }
  validates_length_of :other_symptoms, minimum: 0, maximum: 255, allow_blank: true

  reverse_geocoded_by :latitude, :longitude

  def sick_percentage_in_5km_radius
    sick_percentage_in_radius(5)
  end

  private

  def sick_percentage_in_radius(km_radius)
    sick = self.class.near([latitude, longitude], km_radius, units: :km)
             .where(healthy: false)
             .where.not(id: id)
             .count(:all)
    healthy = self.class.near([latitude, longitude], km_radius, units: :km)
                .where(healthy: true)
                .where.not(id: id)
                .count(:all)

    total = healthy + sick

    return 0 if total == 0

    sick.to_f / total
  end
end
