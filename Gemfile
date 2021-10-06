source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# For now, pin version to 1.2.1 because 1.2.2 causes weird performance
# problems when connecting via TCP
gem 'pg', '1.2.1', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Sidekiq
# https://github.com/mperham/sidekiq/
gem 'sidekiq', '~> 6.2'

# Infer locale from HTTP Accept-Language header
# https://github.com/iain/http_accept_language/
gem 'http_accept_language', '~> 2.1', '>= 2.1.1'

# Scout Monitoring
gem 'scout_apm', '~> 2.6', '>= 2.6.7'

# Maybe a better API for storing lat lng locations and doing nearby queries?
# rubygeocoder.com
gem 'geocoder', '~> 1.6', '>= 1.6.2'

# Inline SVGs
# https://github.com/jamesmartin/inline_svg/
gem 'inline_svg', '~> 1.7', '>= 1.7.1'

# Send Web Push Notifications
gem 'webpush', '~> 1.0'

# Serviceworker, needed for push notifications
gem 'serviceworker-rails', '~> 0.6.0'

# maxminddb reader for reading the maxmind ip geolocation db
# https://github.com/yhirose/maxminddb/
gem 'maxminddb', '~> 0.1.22'
