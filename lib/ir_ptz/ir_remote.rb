require 'arduino_ir_remote'
module IrPtz
  class IrRemote
    def initialize
      @ir = ArduinoIrRemote.connect IrPtz.configuration.device_path
    end

    ArduinoIrRemote::DATA['actions'].keys.each do |action|
      define_method(action) do
        if ir_code = ArduinoIrRemote::DATA['actions'][action]
          ir.write ir_code
        end
      end
    end

    private

    attr_reader :ir
  end
end
