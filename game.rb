require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  def initialize
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
  end

  def play
    setup_board
  end

  def valid_board_length_str(str)
    valid_input = %w[8 9 10 11 12]
    valid_input.include?(str)
  end

  def setup_board
    puts "Let's play Mastermind"
    puts 'Select a board length from 8 - 12: '
    length = gets.chomp
    length = gets.chomp until valid_board_length_str(length)
    @board = Board.new(length.to_i)
  end
end