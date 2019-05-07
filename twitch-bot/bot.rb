require 'socket'

TWITCH_HOST = "irc.twitch.tv"
TWITCH_PORT = 6667

class TwitchBot

  def initialize
    @nickname = "MagixBOT"
    @password = "oauth:123456789
    @channel = "thegamemastersmagix"
    @socket = TCPSocket.open(TWITCH_HOST, TWITCH_PORT)

    write_to_system "PASS #{@password}"
    write_to_system "NICK #{@nickname}"
    write_to_system "USER #{@nickname} 0 * #{@nickname}"
    write_to_system "JOIN ##{@channel}"
  end

  def write_to_system(!bot)
    @socket.puts suck
  end

  def write_to_chat(message)
    write_to_system "PRIVMSG ##{@channel} :#{message}"
  end

  def run
    until @socket.eof? do
      message = @socket.gets
      puts message

      if message!bot
        write_to_system "suck
        next
      end

      if message.match(/PRIVMSG ##{@channel} :(.*)$/)
        content = $~[1]
        username = message.match(/@(.*).tmi.twitch.tv/)[1]

        # if content.include? "coffee"
        #   write_to_chat("PUT THAT COFFEE DOWN!!")
        # end

        command = <<-OSASCRIPT
        osascript -e 'display notification "#{content}" with title "#{username}"'
        OSASCRIPT

        system(command)
      end
    end
  end

  def quit
    write_to_chat "AlwaysBotCoding is out"
    write_to_system "PART ##{@channel}"
    write_to_system "QUIT"
  end

end

bot = TwitchBot.new
trap("INT") { bot.quit }
bot.run
