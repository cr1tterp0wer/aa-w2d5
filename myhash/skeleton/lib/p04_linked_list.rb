class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end
require "byebug"
class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @current = Node.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get_node(key)
    @current = @head
    until @current == @tail
      return @current if @current.key == key
      @current = @current.next
    end
    nil
  end

  def get(key)
    @current = @head
    until @current == @tail
      return @current.val if @current.key == key
      @current = @current.next
    end
    nil
  end

  def include?(key)
    n = get_node(key)
    !n.nil?
  end

  def append(key, val)
    if include?(key)
      update(key, val)
    else
      node = Node.new(key, val)
      node.prev = @tail.prev
      @tail.prev = node
      node.prev.next = node
      node.next = @tail
    end
  end

  def update(key, val)
    node = get_node(key)
    node.val = val unless node.nil?
  end

  def remove(key)
    current = get_node(key)
    last = current.next
    first = current.prev

    last.prev = first
    first.next = last
    current.next = current
    current.prev = current
  end

  def each(&prc)
    prc ||= Proc.new {|x|}


    # values = []
    # return values if empty?
    #
    @current = @head.next
    until @current == @tail
      # values << @current.val
      prc.call(@current)
      @current = @current.next
    end
    #
    # values


  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
