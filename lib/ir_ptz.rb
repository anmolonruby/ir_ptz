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
    attr_accessor :escape_key, :left_key, :right_key, :up_key, :down_key
    attr_accessor :in_key, :out_key, :help_key, :device_path, :action_mappings

    def initialize
      self.escape_key  = 'e'
      self.help_key    = '?'
      self.action_mappings = {
        'h' => 'pan_left',
        'l' => 'pan_right',
        'k' => 'tilt_up',
        'j' => 'tilt_down',
        'i' => 'zoom_in',
        'o' => 'zoom_out'
      }
      self.device_path = ENV['ARDUINO'] || '/dev/tty.usbmodem401321'
    end
  end
end

require "ir_ptz/version"
require 'arduino_ir_remote'
require "ir_ptz/ir_remote"
require "ir_ptz/command_line"
