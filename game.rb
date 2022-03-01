# a class for managing the other mastermind classes (board and player classes)
# responsible for initializing players and the board as well as running a gameplay loop

require_relative 'board'
require_relative 'code_validator'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  def initialize
    @code_validator = CodeValidator.new
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
  end

  def play
    setup_board
    start_turn until game_over?
    if @board.winner?(@player_2.code)
      puts "#{@player_1.name} cracked the code"
    else
      puts "You've been bamboozled; the code was: "
      @player_2.code.each { |peg| print '  '.colorize(background: peg) + ' ' }
      puts
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
      system('clear')
      puts 'Invalid length; enter a number between 8 and 12: '
      length = gets.chomp
    end
    @board = Board.new(length.to_i, @player_2.code)
    system('clear')
  end

  def start_turn
    str = @player_1.guess_code
    until @code_validator.valid_code?(str)
      system('clear')
      puts 'Invalid code'
      str = @player_1.guess_code
    end
    system('clear')
    guess_code = @code_validator.convert_to_symbols(str)
    @board.update(guess_code)
  end

  def game_over?
    @board.winner?(@player_2.code) || @board.full?
  end
end