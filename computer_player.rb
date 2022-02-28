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