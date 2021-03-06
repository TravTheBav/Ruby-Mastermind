# a human player class
# instances of class have a name and can get input from the player

class HumanPlayer
  attr_accessor :code
  attr_reader :name

  def initialize
    @name = input_name
  end

  def input_name
    puts 'Enter your name: '
    gets.chomp
  end

  def guess_code
    puts 'Guess a code with 4 colors and no spaces (e.g. "rgby")'
    puts 'Available colors are r (red), g (green), b (blue), y (yellow),'
    puts 'm (magenta), and w (white):'
    gets.chomp
  end

  def generate_code
    puts 'Enter a secret code with 4 colors and no spaces (e.g. "rgby")'
    puts 'Available colors are r (red), g (green), b (blue), y (yellow),'
    puts 'm (magenta), and w (white):'
    @code = gets.chomp
  end

  # does nothing; for duck typing purposes
  def update_matched_colors(direct_matches) end
end
