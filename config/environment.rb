# Load the rails application
require File.expand_path('../application', __FILE__)

# setup dragonfly configuration before environment-specific configuration
require 'dragonfly/rails/images'

# Initialize the rails application
Living5to9Com::Application.initialize!
