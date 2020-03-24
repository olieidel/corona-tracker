module CoronaTracker
  DICT = JSON.parse(File.read('./lib/assets/countrycode-latlong.json'))

  class CountryToLatLong
    attr_accessor :found, :latitude, :longitude

    # Note that looked up and returned latitude and longitude are
    # strings. Better solution would be decimals, but strings are okay
    # for now as this is just passed down to js where it's parsed
    # again.
    def initialize(iso_country_code)
      if coords = DICT[iso_country_code.downcase]
        lat, lng = coords
        self.found = true
        self.latitude = lat
        self.longitude = lng
      else
        self.found = false
      end
    end
  end
end
