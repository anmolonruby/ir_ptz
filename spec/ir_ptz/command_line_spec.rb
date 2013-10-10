require 'spec_helper'
require 'ir_ptz'
require 'ir_ptz/ir_remote'

describe IrPtz::CommandLine do
  context 'non remote commands' do
    let(:escape_key) { IrPtz.configuration.escape_key }
    let(:bad_key)    { '.' }
    let(:getch_stub) { STDIN.stubs(:getch) }
    subject(:cli)    { IrPtz::CommandLine.new }

    describe '#run' do
      before { cli.stubs(:puts) }

      it 'prints the instructions' do
        instructions = cli.send(:instructions)
        getch_stub.returns escape_key

        cli.run

        expect(cli).to have_received(:puts).with(instructions)
      end

      it 'listens for the escape key and exits upon receipt' do
        getch_stub.returns escape_key

        cli.run

        expect(cli).to have_received(:puts).with('Goodbye!')
      end

      it 'prints the instruction when a bad key is pressed' do
        instructions = cli.send(:instructions)
        getch_stub.returns bad_key, escape_key

        cli.run

        # twice - once at the start and once for the bad key
        expect(cli).to have_received(:puts).with(instructions).twice
      end

      it 'loops until the escape key is pressed' do
        instructions = cli.send(:instructions)
        getch_stub.returns bad_key, bad_key, escape_key

        cli.run

        # trice - once at the start and once for each bad key press
        expect(cli).to have_received(:puts).with(instructions).times(3)
      end
    end

    context 'remote specific commands' do
      it 'passes commands to IR Remote' do
        expect_key_delegates_to_remote IrPtz.configuration.left_key,  :pan_left
        expect_key_delegates_to_remote IrPtz.configuration.right_key, :pan_right
        expect_key_delegates_to_remote IrPtz.configuration.up_key,    :tilt_up
        expect_key_delegates_to_remote IrPtz.configuration.down_key,  :tilt_down
        expect_key_delegates_to_remote IrPtz.configuration.in_key,    :zoom_in
        expect_key_delegates_to_remote IrPtz.configuration.out_key,   :zoom_out
      end
    end
  end
end
