class Questionnaire < ApplicationRecord
  validates_presence_of :latitude, :longitude, :accuracy
  validates :healthy, :tested, :fever, :cough,
            inclusion: { in: [true, false] }
  validates_length_of :other_symptoms, minimum: 0, maximum: 255, allow_blank: true

  def to_feature
    {
      "type" => "Feature",
      "geometry" => {
        "type" => "Point",
        "coordinates" => [browser_location.lon, browser_location.lat, 0]
      },
      "properties" => {
        "fever" => fever,
        "cough" => cough
      }
    }
  end
end
