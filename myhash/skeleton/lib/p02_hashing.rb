
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      prime = get_prime(i+1)
      sum += ((el.hash + prime)).hash
    end
    sum
  end

  def is_prime?(n)
    return false if n<=1
    (2...n).none? {|i| n % i ==0}
  end

  def get_prime(n)
    i = 1
    primes= []
    until primes.length == n
      primes  << i if is_prime?(i)
      i += 1
    end
    primes.last
  end

end

class String
  def hash
    self.split('').map(&:ord).hash
  end
end

class Symbol
  def hash
    self.to_s.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash

    key_val_pairs = []
    self.to_a.sort.each do |tupe|
      key_val_pairs << tupe.hash
    end

    key_val_pairs.sort.hash
  end
end
