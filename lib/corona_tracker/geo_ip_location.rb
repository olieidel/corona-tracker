module CoronaTracker
  DB = MaxMindDB.new('./lib/assets/GeoLite2-Country.mmdb')

  class GeoIpLocation
    def self.lookup(ip)
      maxmind_lookup = DB.lookup(ip)
      if country_code = maxmind_lookup.country.iso_code
        CoronaTracker::CountryToLatLong.new(country_code)
      end
    end
  end
end
