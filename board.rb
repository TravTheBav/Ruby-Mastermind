require 'colorize'

class Board
  attr_reader :length, :current_row

  # red, green, blue, yellow
  @@colors = %i[red blue green yellow]

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
      if row.none?
        row.each { print '__ ' }
      else
        row.each { |peg| print '  '.colorize(background: peg) + ' ' }
      end
      2.times { puts }
    end
  end

  def enter_code(code, current_row)
    @rows[current_row] = code
  end

  def increment_current_row
    @current_row += 1
  end

  def valid_code?(code)
    return false if code.length != 4

    valid_chars = 'rgby'
    code.each_char { |char| return false unless valid_chars.include?(char.downcase) }
    true
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

  # converts a string into an array of symbols
  def convert_to_symbols(code)
    code.split('').map do |char|
      case char.downcase
      when 'r'
        :red
      when 'g'
        :green
      when 'b'
        :blue
      when 'y'
        :yellow
      end
    end
  end

  def update(str)
    guess_code = convert_to_symbols(str)
    enter_code(guess_code, @current_row)
    increment_current_row
    render
    show_matches(guess_code)
  end

  def show_matches(guess_code)
    puts "Direct Matches: #{direct_matches(guess_code, @answer_code)}"
    puts "Indirect Matches: #{indirect_matches(guess_code, @answer_code)}"
  end

  def full?
    current_row >= length
  end

  def winner?(code_to_match)
    @rows.one? { |row| row == code_to_match }
  end
end
