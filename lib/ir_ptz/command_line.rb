require 'io/console'

module IrPtz
  class CommandLine
    attr_reader :ir_remote

    def initialize
      # ensure_configured
      @ir_remote = IrRemote.instance
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
        when config.record_key
          ir_command_recorder.record.save
        else
          if action = action(key)
            ir_remote.send action(key)
          else
            print_instructions
          end
        end
      end
    end

    private

    def ir_command_recorder
      IrCommandRecorder
    end

    def action(key)
      config.action_mappings[key]
    end

    def config
      IrPtz.configuration
    end

    def print_instructions
      puts instructions
    end

    def instructions
      title        = "\nThe following key commands are available:\n"
      exit_text    = "\t'#{config.escape_key}' to exit."
      help_text    = "\t'#{config.help_key}' for help"
      record_text  = "\t'#{config.record_key}' record a new command"
      custom_text  = config.action_mappings.map { |k, v| "\t'#{k}' to #{v}" }
      instructions = [title, exit_text, help_text, record_text] + custom_text
      instructions.join "\n"
    end
  end
end
