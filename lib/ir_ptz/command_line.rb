require 'io/console'

module IrPtz
  class CommandLine
    attr_reader :ir_remote

    def initialize
      # ensure_configured
      @ir_remote = IrRemote.new
    end

    def run
      print_instructions

      while key = STDIN.getch
        case key
        when config.escape_key
          puts 'Goodbye!'
          break
        when config.help_key
          print_instructions
        when config.left_key
          ir_remote.pan_left
        when config.right_key
          ir_remote.pan_right
        when config.down_key
          ir_remote.tilt_down
        when config.up_key
          ir_remote.tilt_up
        when config.in_key
          ir_remote.zoom_in
        when config.out_key
          ir_remote.zoom_out
        else
          print_instructions
        end
      end
    end

    private

    def config
      IrPtz.configuration
    end

    def print_instructions
      puts instructions
    end

    def instructions
      %Q{
        Use '#{config.up_key}' and '#{config.down_key}', to tilt
        Use '#{config.left_key}' and '#{config.right_key}' to pan
        Use '#{config.escape_key}' to exit.
        Use '#{config.help_key}' for help
      }
    end
  end
end
