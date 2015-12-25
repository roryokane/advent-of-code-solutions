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



def sum_numbers_not_in_red_objects(json)
  tree = JSON.parse(json)
  0 + sum_of_numbers_not_in_red_objects_recursive(tree)
end

def sum_of_numbers_not_in_red_objects_recursive(node)
  case node
  when Array
    sum_of_allowed_numbers_recursive(node)
  when Hash
    if node.values.include?("red")
      0
    else
      # I don’t have to look at node.keys because keys are always strings
      # in JSON, and it was specified that no strings have numbers
      sum_of_allowed_numbers_recursive(node.values)
    end
  when Numeric
    node
  else
    0
  end
end

def sum_of_allowed_numbers_recursive(node_enum_to_be_counted)
  return node_enum_to_be_counted.map do |sub|
    sum_of_numbers_not_in_red_objects_recursive(sub)
  end.reduce(0, :+)
end



if __FILE__ == $0
  json_with_nums = $stdin.read
  puts sum_extracted_numbers(json_with_nums)
  puts sum_numbers_not_in_red_objects(json_with_nums)
end
