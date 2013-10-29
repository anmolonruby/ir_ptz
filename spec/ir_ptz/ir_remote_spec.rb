require 'spec_helper'
require 'ir_ptz'
require 'arduino_ir_remote'

describe IrPtz::IrRemote do
  subject(:ir)     { IrPtz::IrRemote.instance }
  let(:arduino_ir) { mock }

  before do
    ir.stubs(:ir).returns arduino_ir
  end

  # concrete example
  describe 'zoom_in' do
    before do
      arduino_ir.stubs(:write)
      ArduinoIrRemote::DATA['actions']['zoom_in'] = 'some value'
    end

    it 'sends the zoom in signal to the board' do
      ir.zoom_in
      expect(arduino_ir).to have_received(:write).with 'some value'
    end
  end

  # dynamic example
  ArduinoIrRemote::DATA['actions'].keys.each do |action|
    describe 'actions' do
      before do
        ArduinoIrRemote::DATA['actions'][action] = 'some value'
        arduino_ir.stubs(:write)
      end

      it 'can send a defined singnal to the board' do
        ir.send(action)
        expect(arduino_ir).to have_received(:write).with 'some value'
      end
    end
  end

  describe '#read_code' do
    it 'returns the read in signal'
  end
end
