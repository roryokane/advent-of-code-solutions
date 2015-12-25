require 'json'

def parse_number_string(num_str)
  array_str = '[' + num_str + ']'
  array = JSON.parse(array_str)
  return array[0]
end

def extract_numbers(json_with_nums)
  extract_number_strings(json_with_nums).map do |num_str|
    parse_number_string(num_str)
  end
end

if __FILE__ == $0
  json_with_nums = $stdin.read
  nums = extract_numbers(json_with_nums)
  puts nums.reduce(0, :+)
end
