class Calculator
  attr_reader :input_strings

  def initialize(*inputs)
    joined_input = inputs.join
    cleaned_input = joined_input.split(', "').map do |str|
      str.gsub('"', '').gsub('\\n', ',')
    end
    @input_strings = cleaned_input
  end

  def add
    begin
      results = []

      input_strings.each do |string|
        delimiter = ","
        
        # Check for custom delimiter syntax at the beginning
        if string.start_with?("//")
          delimiter = string[2]
          string.slice!(0..3)  # Remove the delimiter declaration
        end

        raise "Invalid character at the end of string" if string[-1] == ','

        numbers = string.split(delimiter).map(&:to_i)

        negative_numbers = numbers.select(&:negative?)
        unless negative_numbers.empty?
          raise "Negative numbers not allowed: #{negative_numbers.join(', ')}"
        end

        results << numbers.sum
      end

      results.join(', ')
    rescue => error
      error.message
    end
  end
end
