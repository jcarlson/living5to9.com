source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'rack', '1.2.3' # Dreamhost seems to have a problem with 1.2.1 being the system version

# Database gems
group :production do
  gem 'mysql2', '~> 0.2.0' # MySQL in production
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
gem 'carrierwave'
gem 'fog'

# Inherited Resources for cleaner controllers
gem 'inherited_resources'

# SASS support
gem 'sass'

# Jquery plugin
gem 'jquery-rails'
