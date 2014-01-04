require 'bundler/setup'
require 'eventmachine'

class FlipServer < EM::Connection
  def post_init
    puts 'Client connecting'
  end

  def unbind
    puts 'Client disconected'
  end

  def receive_data(data)
    puts "<< #{data}"
    puts ">> #{data.strip.reverse}"
    send_data "#{data.strip.reverse}\n"
  end
end

EM.run do
  EM.start_server '0.0.0.0', 9000, FlipServer
  puts 'Server running on port 9000'
end
