#!/usr/bin/ruby

# --------------------------------------------------------------
# how to access files with and without code blocks
File.readable?( "dummytext.txt" )   # => true
File.writable?( "dummytext.txt" )   # => true
File.executable?( "dummytext.txt" ) # => false
File::directory?( "dummytext.txt" ) # => false

puts " ..........not using code blocks"
aFile = File.new("dummytext.txt", "r")
   # ... process the file
   puts "#{aFile.path}"
aFile.close

puts " ..........using code blocks"
File.open("dummytext.txt", "r") do |aFile|
   # ... process the file
   puts "#{aFile.path}"
end


# --------------------------------------------------------------
# translate array to an hash
a = ["one", 1, "two", 2, "three", 3]
h = Hash[*a]    # * is the splat operator - takes an array and converst to a literal list
puts "array to hash #{a.inspect} to #{h.inspect}"

# translate hash to an array
a1 = h.values
puts "hash to array #{h.inspect} to #{a1.inspect}"


# iterate through a hash map
h.map { |key, value| puts "#{value}" }


# --------------------------------------------------------------
# queues, stacks, arrays, lists and sets



# --------------------------------------------------------------
# print contents of an array of sixteen numbers, four numbers at a time
a = (0..16).to_a
i = 0
a.each do |x|
   puts "#{a[i,4].inspect}" if(i%4 == 0)
   i += 1
end

(0..16).each_slice(4) {|x| puts "#{x.inspect}"}
(0..16).each_slice(4) {|x| p x}   # short-cut for above



# --------------------------------------------------------------

class Tree
   attr_accessor :children, :node_name
   def initialize(data)
       data.each do |key, value|
          @node_name = key
          @children = value.map {|(key, value)| Tree.new(key => value)}
       end
       # @children = children
       # @node_name = name
   end
   def visit_all(&block)
       visit &block
       children.each {|c| c.visit_all &block}
   end
   def visit(&block)
       block.call self
   end
end
hash_tree = Tree.new({'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {},
'child 4' => {} } } })
hash_tree.visit_all {|node| puts node.node_name}

