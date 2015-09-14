require 'gosu'
require_relative 'Line'

class Map
  attr_reader :lines
  def initialize ()
    @lines = []
    @state = 0
    createMap()
  end
  
  def createMap
    for i in (1..10) do
      @lines.push(Line.new(true))
    end
  end

  def draw()
    index = 0
  	for value in @lines do
      value.draw(@state, index)
      index += 1
    end
  end
  
  def update
    max = 80
    if (max == 80)
      @state = 0
      @lines.shift
    else
      @state += 20
    end
  end

  def acelerar
    @vel_x += Gosu::offset_x(@angulo, 0.5)
    @vel_y += Gosu::offset_y(@angulo, 0.5)
  end

  def detectColision(space)
    return (@lines.first.cars[space]) ? 0 : 10 
  end
  
end