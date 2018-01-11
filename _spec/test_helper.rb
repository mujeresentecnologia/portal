# Require all of the necessary gems
require 'rspec'
require 'capybara/rspec'
require 'rack/jekyll'
require 'rack/test'

RSpec.configure do |config|
  Capybara.app = Rack::Jekyll.new(force_build: true)
end