require 'arduino_ir_remote'
require 'singleton'

module IrPtz
  class IrRemote
    TIME_NEEDED_BETWEEN_IR_BLAST = 0.18 # seconds

    include Singleton

    IrPtz.configuration.actions.keys.each do |action|
      define_method(action) do
        if actions.max != actions.size
          actions.push action
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

    attr_reader :ir, :actions, :ir_thread

    def initialize
      @ir       = ArduinoIrRemote.connect IrPtz.configuration.device_path
      @actions  = SizedQueue.new(1)
      @ir_thread = Thread.new do
        loop do
          action = actions.pop(false) # wait for action

          if ir_code = IrPtz.configuration.actions[action]
            ir.write ir_code
          end

          sleep TIME_NEEDED_BETWEEN_IR_BLAST
        end
      end
    end
  end
end
