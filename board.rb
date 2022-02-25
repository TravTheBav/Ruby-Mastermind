class Board
  @@colors = [:R, :G, :B, :Y] #red, green, blue, yellow
  
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
            row.each { print '_' + ' ' }
        else
            row.each { |peg| print peg.to_s + ' ' }
        end
        puts
    end
  end

  def enter_code(current_row, code)
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

  # a direct match occurs if a char in str matches a char in code at the same index
  def direct_matches(str, code)
    matches = 0
    str.each_char.with_index { |char, idx| matches += 1 if char == code[idx] }
    matches
  end

  # an indirect match occurs if an unmatched char in str is contained in code's unmatched chars
  def indirect_matches(str, code)
    unmatched_str_chars = []
    unmatched_code_chars = []
    str.each_char.with_index do |char, idx|
      unless char == code[idx]
        unmatched_str_chars << char
        unmatched_code_chars << code[idx]
      end
    end
    unmatched_code_chars.intersection(unmatched_str_chars).length
  end

end
