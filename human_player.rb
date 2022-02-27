class HumanPlayer
  def initialize
    @name = get_name
  end

  def get_name
    puts 'Enter your name: '
    gets.chomp
  end

  def get_input
    puts 'Enter a code with 4 colors and no spaces (e.g. "rgby")'
    puts 'Available colors are r (red), g (green), b (blue), and y (yellow): '
    gets.chomp
  end
end