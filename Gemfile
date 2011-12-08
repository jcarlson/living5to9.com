source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'rack', '1.3.2'
gem 'rake', '0.9.2'

# Database gems
group :production do
  gem 'mysql2' # MySQL database for Dreamhost
  gem 'therubyracer' # JavaScript runtime for Dreamhost
end
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3' # sqlite3 elsewhere; production cannot support sqlite3
end

# Validate dates, times, and datetimes
gem 'validates_timeliness'

# Helper for serving "dynamic static" pages
gem 'high_voltage'

# Helper for building tables, especially calendars
gem 'table_builder'

# Handle file uploads
gem 'dragonfly'
gem 'rmagick', :require => 'RMagick'

# Inherited Resources for cleaner controllers
gem 'inherited_resources'

# JQuery plugin
gem 'jquery-rails'

# Active Admin for admin GUI
gem 'activeadmin', '0.3.2'
gem 'sass-rails', '~> 3.1.0'

# Markdown support
gem 'redcarpet'

# Draper, for model decoration
gem 'draper'

# My custom Rails::Engine for handling slugs
gem 'slug-engine'

# Asset pipeline support
group :assets do
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

# Testing gems
group :development, :test do
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'growl'
  gem 'launchy'
  gem 'timecop'
end
