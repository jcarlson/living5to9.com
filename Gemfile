source 'http://rubygems.org'

gem 'rails', '3.1.0'
#gem 'rack', '1.2.1' # Dreamhost seems to have a problem with 1.2.1 being the system version

# Database gems
group :production do
  gem 'mysql2' # MySQL in production
end
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3' # sqlite3 elsewhere; production cannot support sqlite3
end

# Validate dates, times, and datetimes
gem 'validates_timeliness'

# Helper for serving "dynamic static" pages
gem 'high_voltage'

# Handle file uploads
gem 'rmagick'
gem 'carrierwave', :git => 'git@github.com:jcarlson/carrierwave.git'
gem 'fog'

# Inherited Resources for cleaner controllers
gem 'inherited_resources'

# Asset pipeline support
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

# JQuery plugin
gem 'jquery-rails'
