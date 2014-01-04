require 'bundler/setup'
require 'eventmachine'

EM.run do
  EM.add_timer(5) do
    puts 'Boom'
    EM.stop
  end

  # timer = EM::PeriodicTimer.new(5) do
    # puts 'Tick'
  # end
  EM.add_periodic_timer(1) do
    puts 'Tick'
  end
end

