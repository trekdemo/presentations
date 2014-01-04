require 'bundler/setup'
require 'eventmachine'

EM.run do
  puts "reactor thread: #{Thread.current}"

  EM.defer do
    puts "I'm on       #{Thread.current}"
    sleep(2)
    puts "finished on  #{Thread.current}"
    EM.stop
  end

  blk = -> {
    puts "\tI'm on      #{Thread.current}"
    sleep(1)
    puts "\tfinished    #{Thread.current}"
    'cool'
  }

  callback = ->(arg) {
    puts "\tCallback on #{Thread.current} with arg: #{arg}"
  }

  EM.defer blk, callback

end
