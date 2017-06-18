# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
environment_variables = File.join(Rails.root, 'config', 'initializers', 'environment_variables.rb')
load(environment_variables) if File.exist?(environment_variables)

Rails.application.initialize!
