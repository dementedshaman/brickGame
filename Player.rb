require 'gosu'

class Player
  attr_reader :score
  attr_reader :space
  def initialize ()
    @imagem = Gosu::Image.new("car.png")
    @score = 0
    @space = 1
  end
  
  def moveRight()
    if(@space < 2)
      @space += 1
    end
  end
  
  def moveLeft()
    if(@space > 0)
      @space -= 1
    end
  end
  
  def draw()
    x = @space * 60 + 30
    @imagem.draw_rot(x, 440, 1, 0)
  end
  
end