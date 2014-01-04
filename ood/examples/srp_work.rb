class Gear
  attr_accessor :chainring, :cog
  def initialize(chainring, cog)

  def ratio
    chainring / cog.to_f
  end
end

Gear.new.ra
