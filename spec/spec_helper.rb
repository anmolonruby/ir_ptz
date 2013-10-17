require 'mocha/api'
require 'bourne'
require 'helpers'

data_file = File.join(File.dirname(File.expand_path(__FILE__)), '../data/ir_remote.yml')
ENV["IR_DATA_FILE"] = data_file

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Helpers
end
