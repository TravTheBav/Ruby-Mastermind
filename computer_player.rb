# a class for a basic AI player
# can currently generate a random color code from the board classes given colors array

require_relative 'board'

class ComputerPlayer
  attr_reader :code

  def initialize
    @code = generate_code
  end

  def generate_code
    code = []
    4.times { code << Board.colors.sample }
    code
  end
end