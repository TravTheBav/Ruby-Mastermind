# a class for managing the other mastermind classes (board, code_validator, and player classes)
# responsible for running the main gameplay loop

require_relative 'board'
require_relative 'code_validator'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  def initialize
    @code_validator = CodeValidator.new    
  end

  def play
    puts "Let's play Mastermind"
    setup_players
    setup_secret_code
    setup_board
    start_turn until game_over?
    if @board.winner?(@player_2.code)
      puts "#{@player_1.name} cracked the code"
    else
      puts "#{@player_2.name} wins; the code was: "
      @player_2.code.each { |peg| print '  '.colorize(background: peg) + ' ' }
      puts
    end
  end

  def setup_board
    @board = Board.new(12, @player_2.code)
  end

  def setup_players
    option = select_roles
    option = select_roles until %w[1 2].include?(option)
    case option
    when '1'
      @player_1 = HumanPlayer.new
      @player_2 = ComputerPlayer.new
    when '2'
      @player_1 = ComputerPlayer.new
      @player_2 = HumanPlayer.new
    end
  end

  def setup_secret_code
    @player_2.generate_code
    @player_2.generate_code until @code_validator.valid_code?(@player_2.code)
    @player_2.code = @code_validator.convert_to_symbols(@player_2.code)
  end

  def select_roles
    puts 'Would you like to be the code breaker or the code maker?'
    puts 'Enter 1 to be the code breaker'
    puts 'Enter 2 to be the code maker'
    gets.chomp
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
    direct_matches = @board.direct_matches(guess_code, @board.answer_code)
    @player_1.update_matched_colors(direct_matches)
    @board.update(guess_code)
  end

  def game_over?
    @board.winner?(@player_2.code) || @board.full?
  end
end
