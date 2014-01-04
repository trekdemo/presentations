chainring = 52                    # number of teeth
cog       = 11
ratio     = chainring / cog.to_f
puts ratio                        # -> 4.72727272727273

chainring = 30
cog       = 27
ratio     = chainring / cog.to_f
puts ratio                        # -> 1.11111111111111























































class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  # gear inches = wheel diameter * gear ratio
  # tire goes around rim twice for diameter
  def gear_inches
    ratio * @wheel.diameter
  end

end

  class Wheel
    def diameter
      rim + tire*2
    end

    def circumference
      diameter * Math.PI
    end
  end
puts Gear.new(52, 11, Wheel.new(x,y)).gear_inches
# -> 137.090909090909

puts Gear.new(52, 11, 24, 1.25).gear_inches
# -> 125.272727272727


















































class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference
# -> 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches
# -> 137.090909090909

puts Gear.new(52, 11).ratio
# -> 4.72727272727273
