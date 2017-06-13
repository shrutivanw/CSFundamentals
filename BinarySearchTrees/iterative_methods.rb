# This file implements Binary Search Tree and its methods using iterative approaches
# Methods implemented
# => insert
# => search
# => height
# => preorder (depth first traversal)
# => postorder (depth first traversal)
# => inorder (depth first traversal)
# => breadth first traversal

## Helper classes - most iterative tree traversals rely on Stack(s) or Queue(s)
# The following provide minimally sufficient implementations in Ruby.
# Encapsuating these allows for changing these in the future without having to change logic in the Tree class
class Stack
  def initialize
    @internal_stack = Array.new()
  end

  def push(value)
    @internal_stack.push(value)
  end

  def pop()
    return @internal_stack.pop()
  end

  def empty?()
    return @internal_stack.empty?
  end
end

class Queue
  def initialize
    @internal_queue = Array.new()
  end

  def enqueue(value)
    @internal_queue.push(value)
  end

  def dequeue()
    return @internal_queue.shift() # simulates dequeue by removing and returning the first element from the front
  end

  def empty?()
    return @internal_queue.empty?
  end
end

# Defines nodes in a Binary Search Tree
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :left
  attr_accessor :right

  def initialize(value, left=nil, right=nil)
    @data = value
    @left = left
    @right = right
  end
end

# Binary Search Tree class
class Tree
  def initialize
    @root = nil
  end

  # Iterative approach for searching for a value in the binary search tree
  def search(value)
    current = @root
    while current != nil
      if current.data == value
        return true
      end
      if value < current.data # search left subtree
        current = current.left
      else
        current = current.right
      end
    end
    # could not find value
    return false
  end

  # Iterative approach to adding a new node to the binary search tree
  def insert(value)
    node_to_insert = Node.new(value, nil, nil)

    if @root == nil
      @root = node_to_insert
      return
    end

    # find the right parent to insert the new node under
    current = @root
    parent = nil
    while current != nil
      parent = current
      if (value <= current.data)
        # value to insert is less than or equal to value in current node
        # explore the left subtree
        current = current.left
      else # right subtree
        current = current.right
      end
    end

    # parent has been located
    # determine whether the new node should left or right child
    if value <= parent.data
      parent.left = node_to_insert
    else
      parent.right = node_to_insert
    end
  end

  # Iterative preorder traversal (Preorder = current left right) using a Stack
  def preorder
    if @root == nil
      return
    end

    stack1 = Stack.new()
    stack1.push(@root)
    while stack1.empty? == false # while stack is not empty
      current = stack1.pop() # pop from stack
      print " #{current.data}" # print its value
      stack1.push(current.right) if current.right != nil
      stack1.push(current.left) if current.left != nil
    end
    print "\n"
  end

  # Iterative inorder traversal (Inorder = left current right) using a Stack
  def inorder
    if @root == nil
      return
    end

    stack1 = Stack.new()
    current = @root
    while current != nil || stack1.empty? == false # while current is not NULL or stack is not empty
      while current != nil
        stack1.push(current)
        current = current.left
      end
      if current == nil && stack1.empty? == false
        current = stack1.pop()
        print " #{current.data}"
        current = current.right
      end
    end
    print "\n"
  end

  # Iterative postorder traversal (Postorder = left right current) using 2 Stacks
  def postorder
    if @root == nil
      return
    end

    stack1 = Stack.new()
    stack2 = Stack.new()

    stack1.push(@root)
    while stack1.empty? != true
      current = stack1.pop()
      stack2.push(current)
      stack1.push(current.left) if current.left != nil
      stack1.push(current.right) if current.right != nil
    end

    while stack2.empty? != true
      current = stack2.pop()
      print " #{current.data}"
    end
    print "\n"
  end

  # Iterative approach to finding the height of the binary tree
  # uses breadth first traversal (level order traversal) to determine the height
  def get_height
    queue1 = Queue.new()
    node_count = 0 # size of queue1

    if @root != nil
      queue1.enqueue(@root)
      node_count += 1
    end

    height = 0
    while node_count > 0
      height += 1

      # remove nodes of this level and add nodes of the next level
      new_node_count = 0
      while node_count > 0
        current = queue1.dequeue()
        node_count -= 1
        if current.left != nil
          queue1.enqueue(current.left)
          new_node_count += 1
        end
        if current.right != nil
          queue1.enqueue(current.right)
          new_node_count += 1
        end
      end
      node_count = new_node_count
      # queue1 now has nodes in the next level
    end

    return height
  end

  # Iterative breadth first traversal using a Queue
  def breadth_first
    if @root == nil
      return
    end

    queue1 = Queue.new()
    queue1.enqueue(@root) # simulates enqueue by ending to the end
    while queue1.empty? == false
      current = queue1.dequeue() # simulates dequeue by removing and returning the first element from the front
      print " #{current.data}"
      queue1.enqueue(current.left) if current.left != nil # add left child
      queue1.enqueue(current.right) if current.right != nil # then add right child
    end
    print " \n"
  end
end

# Main
puts "Let's create a binary search tree!"
my_tree = Tree.new()

print "How many nodes do you want to add? : "
node_count = gets.chomp.to_i
node_count.times do |i|
  print "Enter integer value for node #{i+1}: "
  my_tree.insert(gets.chomp.to_i)
end
puts

puts "Height of the tree created is #{my_tree.get_height}."

# printing values while traversing the tree in different depth first approaches
print "Preorder traversal of the tree created:"
my_tree.preorder

print "Postorder traversal of the tree created:"
my_tree.postorder

print "Inorder traversal of the tree created:"
my_tree.inorder

print "Breadth first traversal of the tree created:"
my_tree.breadth_first

# Search in the tree
response = true
while response == true
  print "Would you like to search for value in the binary search tree? (Y/N): "
  if gets.chomp.capitalize != 'Y'
    response = false
  end

  if response == true
    print "What integer value would you like to search for? "
    value = gets.chomp.to_i
    if my_tree.search(value) == true
      puts "Found #{value} in the binary search tree!"
    else
      puts "#{value} was not found in the binary search tree!"
    end
  end

end
