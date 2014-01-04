require 'bundler/setup'
require 'eventmachine'

class MyDef
  include EM::Deferrable

  def do_something(outcome)
    case outcome
    when :good        then succeed
    when :bad, :evil  then fail
    end
  end
end


EM.run do
  puts 'EM running'
  d1 = MyDef.new
  d1.callback { puts "MyDef 1 went well :)" }
  d1.errback  { puts "MyDef 1 went not so well :(" }

  d2 = MyDef.new
  d2.callback { puts "MyDef 2 went well :)" }
  d2.errback  { puts "MyDef 2 went not so well :(" }

  EM.add_timer(2) do
    d1.do_something :good
    d2.do_something :evil
    d2.errback do
      puts "I'm still alive"
    end
    d2.reset
    d2.errback do
      puts "Nope, I'm ..."
    end
    EM.stop
  end
end
