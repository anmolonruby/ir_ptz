require 'spec_helper'
require 'ir_ptz'

describe IrPtz::IrCommandRecorder do
  describe '#record' do
    subject(:recorder) { IrPtz::IrCommandRecorder }
    let(:title) { "xxx\n" }
    let(:confirmation) { '' }


    before do
      recorder.stubs(:puts)
      recorder.stubs(:print)
      recorder.stubs(:getch).returns("x")
      recorder.stubs(:gets).returns(title, confirmation)
    end

    describe '.get_title' do
      it 'asks the user to enter the command title' do
        recorder.get_title
        expect(recorder).to have_received(:print).with 'Enter command title: '
      end

      it 'reads in the command title' do
        expect(recorder.get_title).to eql 'xxx'
      end

      context 'title already exists' do
        let(:title) { "zoom_in\n" }
        let(:confirmation) { 'Y' }

        it 'asks if you want to override it' do
          recorder.get_title
          expect(recorder).to have_received(:puts).with 'overwrite "zoom_in" ?'
          expect(recorder).to have_received(:print).with '[Y/n] > '
        end

        it 'returns the key if you enter Y' do
          expect(recorder.get_title).to eql title.chomp
        end

        context 'you do not enter Y' do
          let(:confirmation) { 'r' }

          it 'returns nil' do
            expect(recorder.get_title).to eql nil
          end
        end
      end
    end

    it 'creates a new command' do
      IrPtz::IrRemote.stubs(:instance).returns mock(read_code: '93,44')
      ir_command = IrPtz::IrCommandRecorder::Command.new('xxx', 'x', '93,44')
      expect(recorder.record).to eql ir_command
    end
  end
end
