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
end
