source 'http://rubygems.org'

gem 'rails', '3.0.3'

# Database gems
group :production do
  gem 'mysql2', '~> 0.2.6' # MySQL in production
end
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3' # sqlite3 elsewhere; production cannot support sqlite3
end

# Validate dates, times, and datetimes
gem 'validates_timeliness', '~> 3.0.2'

# Helper for serving "dynamic static" pages
gem 'high_voltage', '~> 0.9.2'

# Handle file uploads
gem 'rmagick', '~> 2.13.1'
gem 'carrierwave', '~> 0.5.4'

# Inherited Resources for cleaner controllers
gem 'inherited_resources', '~> 1.2.2'

# SASS support
gem 'sass', '~> 3.1.3'

# Jquery plugin
gem 'jquery-rails', '>= 0.2.6'
