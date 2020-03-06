# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do
  healthy = [true, false].sample

  if healthy
    questionnaire = Questionnaire.new(healthy: healthy,
                                      fever: false,
                                      cough: false)
  else
    questionnaire = Questionnaire.new(healthy: healthy,
                                      fever: [true, false].sample,
                                      cough: [true, false].sample)
  end

  lat = 51.1657 + ((rand * 6) - 3)
  lon = 10.4515 + ((rand * 6) - 3)
  accuracy = rand(100)
  questionnaire.browser_location = BrowserLocation.new(lon: lon, lat: lat, accuracy: accuracy)
  questionnaire.save
end
