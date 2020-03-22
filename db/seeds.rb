# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_boolean
  [true, false].sample
end

def true_with_probability(p)
  if rand < p
    true
  else
    false
  end
end

def random_latitude
  51.1657 + ((rand * 6) - 3)
end

def random_longitude
  10.4515 + ((rand * 6) - 3)
end

def create_entry(healthy: random_boolean, latitude: random_latitude, longitude: random_longitude)
  questionnaire = Questionnaire.new(healthy: healthy)

  if healthy
    fever = false
    cough = false
  else
    fever = random_boolean
    cough = random_boolean
  end

  questionnaire.assign_attributes(
    fever: fever,
    cough: cough,
    tested: random_boolean,
    other_symptoms: "",
    client_uuid: SecureRandom.uuid,
    latitude: latitude,
    longitude: longitude,
    accuracy: rand(100),
    simulated: true
  )

  questionnaire.save
end

SAMPLE_CLUSTERS = { heinsberg: { lat: 51.0663, lng: 6.1055, healthy: 0.2 },
                    berlin: { lat: 52.520008, lng: 13.404954, healthy: 0.5 },
                    heidelberg: { lat: 49.398750, lng: 8.672434, healthy: 0.9 } }

# lat and lng refer to the center of the cluster
def create_entry_in_cluster(lat:, lng:, healthy:)
  # 5 kilometers around center

  lat_deviation = (1.0 / 110.574) * (rand - 0.5) * 5
  lng_deviation = (1.0 / 71.952) * (rand - 0.5) * 5
  create_entry(healthy: true_with_probability(healthy),
               latitude: lat + lat_deviation,
               longitude: lng + lng_deviation)
end

# lat and lng refer to the center of the cluster
def create_cluster(entry)
  200.times do
    create_entry_in_cluster(entry)
  end
end

def create_clusters
  SAMPLE_CLUSTERS.each do |key, value|
    create_cluster value
  end
end

def create_others
  500.times do
    create_entry(healthy: random_boolean)
  end
end

create_clusters
create_others

GenerateHeatmapJob.perform_now(true)
