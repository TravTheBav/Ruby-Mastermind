# a class for a basic AI player
# can either be a code maker or breaker

class ComputerPlayer
  attr_reader :name
  attr_accessor :code

  def initialize
    @name = 'Ruby Mastermind'
    @current_color = nil
    @available_colors = %w[r b g y m w]
    @matched_colors = []
    @permutations = []
  end

  def generate_code
    @code = ''
    4.times { @code += @available_colors.sample }
  end

  def guess_code
    sleep(2)
    if @matched_colors.length < 4
      @current_color = @available_colors.pop
      return @current_color * 4
    end

    calculate_permutations if @permutations.empty?

    @permutations.shuffle.pop.join
  end

  def calculate_permutations
    @matched_colors.permutation { |perm| @permutations << perm }
  end

  def update_matched_colors(amount)
    amount.times { @matched_colors << @current_color }
  end
end
