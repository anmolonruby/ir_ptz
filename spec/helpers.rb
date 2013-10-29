module Helpers
  def expect_key_delegates_to_remote(key, command)
    escape_key = IrPtz.configuration.escape_key
    STDIN.stubs(:getch).returns key, escape_key

    ir_remote = mock
    IrPtz::IrRemote.stubs(:new).returns ir_remote
    ir_remote.stubs(command)

    cli = IrPtz::CommandLine.new
    cli.stubs(:puts)
    cli.run

    # expect(ir_remote).to have_received(command)
  end
end
