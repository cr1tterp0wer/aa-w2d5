require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)

    self[key] << key unless include?(key)
    @count += 1
    if @count >= num_buckets
      @count = 0
      resize!
    end

  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def []=(num, val)
    @store[num.hash % num_buckets] = val
  end

  def num_buckets
    @store.length
  end

  def resize!
    values = @store.flatten
    old_length = num_buckets
    new_length = old_length * 2

    @store = Array.new(new_length) {Array.new}
    values.each do |el|
      insert(el)
    end

  end
end
