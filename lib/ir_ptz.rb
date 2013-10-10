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
    attr_accessor :in_key, :out_key, :help_key, :device_path, :actions

    def initialize
      self.escape_key  = 'e'
      self.left_key    = 'h'
      self.right_key   = 'l'
      self.up_key      = 'k'
      self.down_key    = 'j'
      self.in_key      = 'i'
      self.out_key     = 'o'
      self.help_key    = '?'
      self.device_path = ENV['ARDUINO'] || '/dev/tty.usbmodem401321'
      self.actions     = ['zoom_in', 'zoom_out', 'tilt_up', 'tilt_down', 'pan_left', 'pan_right']
    end
  end
end

require "ir_ptz/version"
require 'bundler/setup'
require 'arduino_ir_remote'
require "ir_ptz/ir_remote"
require "ir_ptz/command_line"
