require 'bundler/setup'

module IrPtz
  class << self
    attr_accessor :configuration
  end

  # Configure IrPtz in ~/.ir_ptz_config.rb to override the defaults
  #
  # @example
  #   IrPtz.configure do |config|
  #     config.device_path = '/dev/tty.usbmodem9999'
  #     config.in_key      = 'a'
  #     config.out_key     = 's'
  #   end
  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
      @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :escape_key, :help_key, :record_key, :actions, :action_mappings
    attr_accessor :device_path

    def initialize
      self.escape_key  = 'e'
      self.help_key    = '?'
      self.record_key  = 'r'
      self.action_mappings = ArduinoIrRemote::DATA['action_mappings']
      self.actions         = ArduinoIrRemote::DATA['actions']
      self.device_path     = ArduinoIrRemote::DATA['device_path']
    end
  end
end

require "ir_ptz/version"
require 'arduino_ir_remote'
require "ir_ptz/ir_remote"
require "ir_ptz/ir_command_recorder"
require "ir_ptz/command_line"
