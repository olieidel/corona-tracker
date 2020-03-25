require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Corona
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths << "#{Rails.root}/lib"

    config.i18n.available_locales = %w(en de)
    config.i18n.default_locale = :en

    config.assets.precompile += %w[serviceworker.js manifest.json]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.mapbox_public_key = "pk.eyJ1Ijoib2xpZWlkZWwiLCJhIjoiY2s3Z2J1bG1lMDlidjNtbzI1MGVlM3czOCJ9.fAXDKOEHx_USnDXah1iENw"

    config.sliding_window = 14.days
    config.default_heatmap_radius_km = 20
  end
end
