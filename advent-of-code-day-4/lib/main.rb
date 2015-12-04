require 'openssl'

class Hasher
  class << self
    def md5(secret_key, number)
      digest = OpenSSL::Digest::MD5.new
      return digest.hexdigest(secret_key + number.to_s)
    end
    
    def lowest_positive_integer_creating_hash_satisfying(secret_key, &predicate)
      num = 1
      hash_str = md5(secret_key, num)
      until predicate.call(hash_str)
        num += 1
        hash_str = md5(secret_key, num)
      end
      return num
    end
    
    def starts_with_zeroes_proc(num_zeroes)
      zeroes_string = "0" * num_zeroes
      return Proc.new { |str| str.start_with?(zeroes_string) }
    end
    
    def lowest_initial_zeroes_added_number(secret_key, num_zeroes)
      lowest_positive_integer_creating_hash_satisfying(secret_key, &starts_with_zeroes_proc(num_zeroes))
    end
  end
end


if __FILE__ == $0
  secret_key = gets.chomp
  puts Hasher.lowest_initial_zeroes_added_number(secret_key, 5)
end
