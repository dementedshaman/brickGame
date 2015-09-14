#encoding: UTF-8
require 'gosu'
require_relative 'Player'
require_relative 'Map'
require_relative 'Line'

class BrickRace < Gosu::Window
  @@formato = [1, 1, Gosu::Color::YELLOW]

  def initialize
    super(190, 480)
    self.caption = "BrickRace"
    @imagem_fundo = Gosu::Image.new("background.png")
    @player = Player.new()
    @map = Map.new
    @fonte = Gosu::Font.new(20)
    @tempo = 0.0
    @estado = "INICIO"
    @lastTime = 2
  end

  def draw
    @imagem_fundo.draw(0, 0, 0)
    if    @estado == "INICIO"  then draw_inicio
    elsif @estado == "JOGANDO" then draw_jogando
    else                            draw_fim     end
  end

  def update
    if    @estado == "INICIO" then update_inicio
    elsif @estado =="JOGANDO" then update_jogando
    #elsif (@estado == "FIM") then
    end
  end

  # Estado: inicio do jogo
  def update_inicio
    if button_down?(Gosu::KbI) then @estado = "JOGANDO" end
  end

  def draw_inicio
    msg = "PRESSIONE [I] PARA COMEÇAR"
    meio = width / 2 - @fonte.text_width(msg, 1) / 2
    @fonte.draw(msg, meio, height/2, 3, *@@formato)
  end

  # Estado: jogando
  def update_jogando
    currentTime = Gosu::milliseconds / 1000.0
    if( currentTime - @lastTime  > 1)
      # eventos
      if button_down?(Gosu::KbRight) or button_down?(Gosu::GpRight) then @player.moveRight end
      if button_down?(Gosu::KbLeft)  or button_down?(Gosu::GpLeft) then @player.moveLeft end   
      # inserir novas estrelas estrelas se necessario
      if @map.lines.size < 8 then
        @map.lines.push(Line.new(true)) 
        @map.lines.push(Line.new) 
      end
  
      plc = @map.detectColision(@player.space)  # catar estrelas
      @map.update                     # atualizar a posicao do jogador
      @tempo += 1.0/60.0                 # incrementar o tempo
      #@player.score = @player.score + plc
      if @tempo.to_i >= 30 or plc == 0 then @estado = "FIM" end         # terminar o jogo depois de 30 segundos
      @lastTime = currentTime
      end
  end

  def draw_jogando
    @player.draw()               # desenhar o jogador
    @map.draw()
    @fonte.draw("Placar: #{@player.score}", 10, 10, 3, *@@formato)
    @fonte.draw("Tempo: #{@tempo.to_i}s",     10, 30, 3, *@@formato)
  end

  # Estado: fim do jogo
  def draw_fim
    msg = "FIM DE JOGO, VOCE FEZ #{@player.score} PONTOS"
    meio = width / 2 - @fonte.text_width(msg, 1) / 2
    @fonte.draw(msg, meio, self.height/2, 3, *@@formato)
  end
end