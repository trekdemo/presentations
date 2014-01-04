require 'bundler/setup'
require 'eventmachine'

class Client < EM::Connection
  def post_init
    puts 'connected'
    send_data 'Hello from Client'
  end

  def unbind
    puts 'disconected'
  end

  def receive_data(data)
    puts ">> #{data}"
    close_connection
    EM.stop
  end
end

EM.run do
  EM.connect 'localhost', 9000, Client
end
