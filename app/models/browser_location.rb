class BrowserLocation < ApplicationRecord
  attr_accessor :lon, :lat

  has_one :questionnaire

  validates_presence_of :lon, :lat

  before_create :set_lonlat

  # def lon
  #   lonlat ? lonlat.lon : nil
  # end

  # def lat
  #   lonlat ? lonlat.lat : nil
  # end

  private

  def set_lonlat
    point = RGeo::Geographic.spherical_factory(srid: 4326).point(lon, lat)
    self.lonlat = point
  end
end
