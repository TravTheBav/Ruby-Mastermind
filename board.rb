class Board
  @@colors = [:R, :G, :B, :Y] #red, green, blue, yellow
  
  def self.colors
    @@colors
  end
  
  def initialize(length)
    @length = length
    @rows = Array.new(@length) { Array.new(4, '_') }
  end 

  def render
    @rows.each do |row|
        row.each { |peg| print peg + ' ' }
        puts
    end
  end
end
