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
    start_turn until game_over?
    if @board.winner?(@player_2.code)
      puts 'You cracked the code'
    else
      puts "You've been bamboozled; the code was #{@player_2.code}"
    end
  end

  def valid_board_length_str(str)
    valid_input = %w[8 9 10 11 12]
    valid_input.include?(str)
  end

  def setup_board
    puts "Let's play Mastermind"
    puts 'Select a board length from 8 - 12: '
    length = gets.chomp
    until valid_board_length_str(length)
      puts 'Invalid length; enter a number between 8 and 12: '
      length = gets.chomp
    end
    @board = Board.new(length.to_i)
  end

  def start_turn
    str = @player_1.guess_code
    until @board.valid_code?(str)
      puts 'Invalid code'
      str = @player_1.guess_code
    end
    system('clear')
    @board.update(str)
    @board.render
    @board.show_matches(str, @player_2.code)
  end

  def game_over?
    @board.winner?(@player_2.code) || @board.full?
  end
end