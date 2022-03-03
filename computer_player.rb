# a class for a basic AI player
# can either be a code maker or breaker

class ComputerPlayer
  attr_accessor :code

  def initialize
    @name = 'Ruby Mastermind'
  end

  def generate_code
    available_colors = %w[r b g y m w]
    @code = ''
    4.times { @code += available_colors.sample }
  end
end
