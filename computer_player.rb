# a class for a basic AI player
# can either be a code maker or breaker

class ComputerPlayer
  attr_reader :code

  def initialize
    @name = 'Ruby Mastermind'
  end

  def generate_code
    available_colors = %i[red blue green yellow magenta white]
    @code = []
    4.times { @code << available_colors.sample }
  end
end
