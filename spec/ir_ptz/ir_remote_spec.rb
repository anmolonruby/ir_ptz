require 'spec_helper'
require 'ir_ptz'
require 'arduino_ir_remote'

describe IrPtz::IrRemote do
  subject(:ir)     { IrPtz::IrRemote.new }
  let(:arduino_ir) { mock }

  before do
    ArduinoIrRemote.stubs(:connect).
      with(IrPtz.configuration.device_path).
      returns(arduino_ir)
  end

  # concrete example
  describe 'zoom_in' do
    before do
      arduino_ir.stubs(:write)
      ArduinoIrRemote::DATA['zoom_in'] = 'some value'
    end

    it 'sends the zoom in signal to the board' do
      ir.zoom_in
      expect(arduino_ir).to have_received(:write).with 'some value'
    end
  end

  # dynamic example
  IrPtz.configuration.actions.each do |action|
    describe 'actions' do
      before do
        ArduinoIrRemote::DATA[action] = 'some value'
        arduino_ir.stubs(:write)
      end

      it 'can senda defined singnal to the board' do
        ir.send(action)
        expect(arduino_ir).to have_received(:write).with 'some value'
      end
    end
  end
end
