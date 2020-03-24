class PagesController < ApplicationController
  def index
    @questionnaire = Questionnaire.new
    cookies.permanent.encrypted[:client_uuid] ||= SecureRandom.uuid

    # Note that looked up and returned latitude and longitude are
    # strings. Better solution would be decimals, but strings are okay
    # for now as this is just passed down to js where it's parsed
    # again.


    if geo_location = CoronaTracker::GeoIpLocation.lookup(request.remote_ip) and geo_location.found
      @initial_coords = { latitude: geo_location.latitude,
                          longitude: geo_location.longitude }

    else
      # Coordinates of Germany
      #
      # Note that these are floats, but the above call would return
      # strings. Great. But doesn't matter again as it's parsed in JS.
      @initial_coords = { latitude: 10.4515,
                          longitude: 51.1657 }
    end
  end
end
