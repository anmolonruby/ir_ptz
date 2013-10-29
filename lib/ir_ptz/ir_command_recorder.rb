require 'io/console'

module IrPtz
  class IrCommandRecorder
    Command = Struct.new(:title, :key, :action_code) do
      def save
        ArduinoIrRemote::DATA['action_mappings'][key] = title
        ArduinoIrRemote::DATA['actions'][title] = action_code
        ArduinoIrRemote::DATA.save
        puts "#{title} saved!"
      end
    end

    def self.record
      command = nil
      title   = get_title
      key     = get_key
      code    = get_ir_code

      @command = Command.new(title, key, code)
    end

    private
    class BlankException < Exception; end
    NON_WHITESPACE_REGEXP = %r![^\s#{[0x3000].pack("U")}]!

    def self.blank?(string)
      res = string !~ NON_WHITESPACE_REGEXP
    end

    def self.get_title
      print 'Enter command title: '
      title = gets.chomp

      if IrPtz.configuration.actions.has_key? title
        puts %Q{overwrite "#{title}" ?}
        print "[Y/n] > "
        return nil unless gets.strip =~ /Y/
      end

      blank?(title) ? get_title : title
    end

    def self.get_key
      puts 'Enter the key to be used to send the command: '
      key = getch

      if IrPtz.configuration.action_mappings.has_key? key
        puts %Q{overwrite "#{args[:read]}" ?}
        print "[Y/n] > "
        return nil unless gets.strip =~ /Y/
      end

      blank?(key) ? get_key : key
    end

    def self.get_ir_code
      ir_code = IrRemote.instance.read_code
      blank?(ir_code) ? get_ir_code : ir_code
    end
    private_class_method :get_ir_code
  end
end
