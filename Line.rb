require 'gosu'

class Line
  attr_reader :cars
  def initialize (empty = false)
    @imagem = Gosu::Image.new("car.png")
    @cars = [false,false,false]
    if !empty then
      createCars()
    end
  end

  def draw(state, index)
    diff = 90
    key = 0
    x = 0
    y = 440
    for value in @cars do
      if(value) then 
        @imagem.draw_rot((key * diff) - state, 440 - index * 80, 1, 0)
      end
      key += 1
    end
  end
  
  def createCars() 
    for i in 0..1 do
       @cars[rand(0..2)] = true
    end
  end
end