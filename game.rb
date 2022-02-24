require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  def initialize
    @board = Board.new(8)
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
  end
  
  def play
    
  end
end