require 'mocha/api'
require 'bourne'
require 'helpers'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Helpers
end
