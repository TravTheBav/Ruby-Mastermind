class Board
  attr_reader :length, :current_row

  # red, green, blue, yellow
  @@colors = %i[R G B Y]

  def self.colors
    @@colors
  end

  def initialize(length)
    @length = length
    @rows = Array.new(@length) { Array.new(4) }
    @current_row = 0
  end

  def render
    @rows.each do |row|
      if row.none?
        row.each { print '_ ' }
      else
        row.each { |peg| print "#{peg} " }
      end
      puts
    end
  end

  def enter_code(code, current_row)
    @rows[current_row] = convert_to_symbols(code)
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

  # a direct match occurs if a char in str matches a char in code at the same index
  def direct_matches(str, code)
    matches = 0
    colors = convert_to_symbols(str)
    colors.each_with_index { |color, idx| matches += 1 if color == code[idx] }
    matches
  end

  # an indirect match occurs if an unmatched char in str is contained in code's unmatched chars
  def indirect_matches(str, code)
    colors = convert_to_symbols(str)
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
    code.split('').map { |char| char.upcase.to_sym }
  end

  def update(code)
    enter_code(code, @current_row)
    increment_current_row
  end

  def show_matches(str, code)
    puts "Direct Matches: #{direct_matches(str, code)}"
    puts "Indirect Matches: #{indirect_matches(str, code)}"
  end

  def full?
    current_row > length
  end

  def winner?(code_to_match)
    @rows.one? { |row| row == code_to_match }
  end
end
