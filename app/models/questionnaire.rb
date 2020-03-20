class Questionnaire < ApplicationRecord
  # has_one :browser_location
  # belongs_to :browser_location

  # accepts_nested_attributes_for :browser_location

  validates :healthy, :tested, :fever, :cough,
            inclusion: { in: [true, false] }
  validates_presence_of :latitude, :longitude, :accuracy

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
