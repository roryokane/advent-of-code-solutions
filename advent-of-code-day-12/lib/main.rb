require 'json'

def parse_number_string(num_str)
  array_str = '[' + num_str + ']'
  array = JSON.parse(array_str)
  return array[0]
end

# converted from the `number` diagram on http://json.org/
JSON_NUMBER_REGEX = /-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+\-]?\d+)?/

def extract_number_strings(json_with_nums)
  json_with_nums.scan(JSON_NUMBER_REGEX)
end

def extract_numbers(json_with_nums)
  extract_number_strings(json_with_nums).map do |num_str|
    parse_number_string(num_str)
  end
end

def sum_extracted_numbers(json_with_nums)
  nums = extract_numbers(json_with_nums)
  return nums.reduce(0, :+)
end

if __FILE__ == $0
  json_with_nums = $stdin.read
  puts sum_extracted_numbers(json_with_nums)
end
