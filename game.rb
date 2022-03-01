# a class for managing the other mastermind classes (board, code_validator, and player classes)
# responsible for running the main gameplay loop

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

  def setup_board
    puts "Let's play Mastermind"
    @board = Board.new(12, @player_2.code)
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
