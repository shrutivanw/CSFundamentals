# This file implements Binary Search Tree and its methods using recursive approaches
# Methods implemented
# => insert
# => search
# => height
# => preorder (depth first traversal)
# => postorder (depth first traversal)
# => inorder (depth first traversal)
# => breadth first traversal

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

  # helper method for search
  def search_helper(current, value)
    if current == nil # node is nil (could be root)
      return false
    elsif value == current.data # found the value being searched
      return true
    elsif value < current.data # search the left subtree
      return search_helper(current.left, value)
    end
    # search the right subtree
    return search_helper(current.right, value)
  end

  # recursive approach for searching for a value in the binary search tree
  def search(value)
    return search_helper(@root, value) # use a helper method. This approach root from being exposed outside the class. (encapsulation)
  end

  # helper method for insert
  def insert_helper(current, value)
    if value <= current.data # new node with value should be inserted in the left subtree
      if current.left != nil # there is a node to the left of current
        return insert_helper(current.left, value)
      else # found the location to insert the new node at
        current.left = Node.new(value, nil, nil)
        return
      end
    else # new node with value should be inserted in the right sub tree
      if current.right != nil # there is a node to the right of current
        return insert_helper(current.right, value)
      else # found the location to insert the new node at
        current.right = Node.new(value, nil, nil)
        return
      end
    end
  end

  # recursive approach to adding a new node to the binary search tree
  def insert(value)
    if @root == nil
      @root = Node.new(value, nil, nil)
      return
    end

    return insert_helper(@root, value) # use a helper method. this approch prevents root from being exposed outside the class. (encapsulation)
  end

  # recursive helper method for preorder traversal
  def preorder_helper(current)
    if current == nil
      return
    end

    print " #{current.data}" # print value at current, current visited
    preorder_helper(current.left) # preorder traverse left subtree recursively
    preorder_helper(current.right) # preorder traverse right subtree recursively
  end

  # Recursive preorder traversal (Preorder = current left right)
  def preorder
    preorder_helper(@root) # encapsulate root
    print "\n"
  end

  # recursive helper method for inorder traversal
  def inorder_helper(current)
    if current == nil
      return
    end

    inorder_helper(current.left) # inorder traverse left subtree recursively
    print " #{current.data}" # print value at current, current visited
    inorder_helper(current.right) # inorder traverse right subtree recursively
  end

  # Recursive inorder traversal (Inorder = left current right)
  def inorder
    inorder_helper(@root) #encapsulate root
    print "\n"
  end

  # recursive helper method for Postorder traversal
  def postorder_helper(current)
    if current == nil
      return
    end

    postorder_helper(current.left) # postorder traverse left subtree recursively
    postorder_helper(current.right) # postorder traverse right subtree recursively
    print " #{current.data}" # print value at current, current visited
  end

  # Recursive postorder traversal (Postorder = left right current)
  def postorder
    postorder_helper(@root) # encapsulate root
    print "\n"
  end

  # helper method to calculate height of the binary search tree recursively
  def height_helper(current)
    if current == nil
      return 0
    end

    # calculate height of left subtree
    height_left = height_helper(current.left)
    # calculate height of right subtree
    height_right = height_helper(current.right)

    if height_left < height_right
      return 1 + height_right
    end
    return 1 + height_left
  end

  # find the height of the binary tree recursively
  def get_height
    return height_helper(@root)
  end

  # helper method for breadth first traversal to print nodes at a given level
  def print_given_level(current, level)
    if current == nil # nothing to print
      return
    end

    if level == 1 # reached the level we want to print
      print " #{current.data}"
    elsif level > 1 # not yet at level we want to print. Print each descendent from current
      print_given_level(current.left, level-1)
      print_given_level(current.right, level-1)
    end
  end

  # helper method for breadth first traversal
  def print_level_order(current)
    height = height_helper(current)
    height.times do |i|
      print_given_level(current, i+1)
    end
  end

  # recursive breadth first traversal
  def breadth_first
    print_level_order(@root)
    print "\n"
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
