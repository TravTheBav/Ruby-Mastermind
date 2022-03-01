# a class representing the game board for mastermind
# tracks filled and empty rows, updates/renders the game board, checks for valid codes, and calculates matches

require 'colorize'

class Board
  attr_reader :length, :current_row

  # red, green, blue, yellow
  @@colors = %i[red blue green yellow magenta white]

  def self.colors
    @@colors
  end

  def initialize(length, answer_code)
    @length = length
    @rows = Array.new(@length) { Array.new(4) }
    @current_row = 0
    @answer_code = answer_code
  end

  def render
    @rows.each do |row|
      render_row(row)
      render_clues(row)
      2.times { puts }
    end
  end

  def render_row(row)
    if row.none?
      row.each { print '__ ' }
    else
      row.each { |peg| print '  '.colorize(background: peg) + ' ' }
    end
    print '   '
  end

  def render_clues(row)
    direct_matches(row, @answer_code).times { print '●'.colorize(:color => :red) + ' ' }
    indirect_matches(row, @answer_code).times { print '●'.colorize(:color => :white) + ' ' }
  end

  def enter_code(guess_code, current_row)
    @rows[current_row] = guess_code
  end

  def increment_current_row
    @current_row += 1
  end

  # a direct match occurs if a symbol in colors matches a symbol in code at the same index
  def direct_matches(colors, code)
    matches = 0
    colors.each_with_index { |color, idx| matches += 1 if color == code[idx] }
    matches
  end

  # an indirect match occurs if an unmatched char in str is contained in code's unmatched chars
  def indirect_matches(colors, code)
    unmatched_input_colors = []
    unmatched_code_colors = []
    colors.each_with_index do |color, idx|
      unless color == code[idx]
        unmatched_input_colors << color
        unmatched_code_colors << code[idx]
      end
    end
    unmatched_code_colors.intersection(unmatched_input_colors).length
  end

  def update(guess_code)
    enter_code(guess_code, @current_row)
    increment_current_row
    render
  end

  def full?
    current_row >= length
  end

  def winner?(code_to_match)
    @rows.one? { |row| row == code_to_match }
  end
end
