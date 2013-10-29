require 'arduino_ir_remote'
require 'singleton'

module IrPtz
  class IrRemote
    include Singleton

    IrPtz.configuration.actions.keys.each do |action|
      define_method(action) do
        if ir_code = IrPtz.configuration.actions[action]
          ir.write ir_code
        end
      end
    end

    def read_code
      data = nil
      end_of_read = nil

      ir.read do |ir_data|
        data = ir_data
        end_of_read = true
      end

      puts "reading.."
      ir.wait { sleep 1; break if end_of_read }
      puts "finished reading!"

      data
    end

    private

    attr_reader :ir

    def initialize
      @ir = ArduinoIrRemote.connect IrPtz.configuration.device_path
    end
  end
end
