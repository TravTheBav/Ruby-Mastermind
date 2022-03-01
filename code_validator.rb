# a class for checking valid strings for colored codes and formatting those codes into arrays of symbols

class CodeValidator
  def valid_code?(code)
    return false unless code.length == 4
    
    valid_chars = 'rgby'
    code.each_char { |char| return false unless valid_chars.include?(char.downcase) }
    true
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
end
