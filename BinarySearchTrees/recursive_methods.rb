# This file implements Binary Search Tree and its methods using recursive approaches
# Methods implemented
# => insert
# => search
# => height
# => preorder (depth first traversal)
# => postorder (depth first traversal)
# => inorder (depth first traversal)
# => breadth first traversal
# => delete

# Defines nodes in a Binary Search Tree
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :left # allow external entities to read or write
  attr_accessor :right # allow external entities to read or write

  def initialize(value, left=nil, right=nil)
    @data = value
    @left = left
    @right = right
  end
end

# Defines the Binary Search Tree class
class Tree
  def initialize
    @root = nil # keep the root private. Not excessible outside this class.
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
  private :search_helper

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

    return insert_helper(@root, value) # use a helper method. this approach prevents root from being exposed outside the class. (encapsulation)
  end
  private :insert_helper

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
  private :preorder_helper

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
  private :inorder_helper

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
  private :postorder_helper

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
  private :height_helper

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
  private :print_given_level
  private :print_level_order

  # helper method for delete_internal
  # returns the in-order successor after the current node in the tree
  def find_inorder_successor(current)
    current = current.right
    while current.left
      current = current.left
    end

    return current
  end

  # helper method for delete
  def delete_internal(current, value)
    return current if current == nil # value not found in the tree

    if value < current.data # explore the left subtree for value
      puts "#{value} is less than current data, #{current.data}, exploring left subtree"
      current.left = delete_internal(current.left, value)
    elsif value > current.data # explore the right subtree for value
      puts "#{value} is greater than current data, #{current.data}, exploring right subtree"
      current.right = delete_internal(current.right, value)
    else # value found at current
      puts "Value found at current"
      if current.right == nil # node with one or no children
        puts "current.right is nil. Setting current.left as current"
        current = current.left # replace current with current.left node
      elsif current.left == nil # node with one child on the right
        current = current.right
      else # current has two children
        # find the in-order successor to current
        temp = find_inorder_successor(current)
        # delete the in-order successor from the right subtree
        current.right = delete_internal(current.right, temp.data)
        # replace current to be the in-order successor value
        temp.left = current.left
        temp.right = current.right
        current = temp
      end
    end
    return current # includes consideration for root needs to be deleted
  end
  private :find_inorder_successor

  # deletes a node with a given data value, if found
  def delete(value)
    @root = delete_internal(@root, value)
  end
  private :delete_internal

end

# Main
puts "Let's create a binary search tree!"
my_tree = Tree.new()

print "How many nodes do you want to add? : " # e.g. 7
node_count = gets.chomp.to_i
node_count.times do |i|
  print "Enter integer value for node #{i+1}: "
  my_tree.insert(gets.chomp.to_i)
end
puts
# enter values in breadth first traversal order to get the tree intended
# example: for the tree below enter: 15, 10, 25, 5, 12, 20, 30
#           15
#        /     \
#      10       25
#     / \       /\
#    5  12    20  30

puts "Height of the tree created is #{my_tree.get_height}."
# should be 3 for the example tree

# printing values while traversing the tree in different depth first approaches
print "Preorder traversal of the tree created:"
my_tree.preorder
# for example: 15 10 5 12 25 20 30

print "Postorder traversal of the tree created:"
my_tree.postorder
# for example: 5 12 10 20 30 25 15

print "Inorder traversal of the tree created:"
my_tree.inorder
# for example: 5 10 12 15 20 25 30

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

# Delete from tree
response = true
while response == true
  print "Would you like to delete a value from the binary search tree? (Y/N): "
  if gets.chomp.capitalize != 'Y'
    response = false
  end

  if response == true
    print "What integer value would you like to delete? "
    value = gets.chomp.to_i

    print "Postorder traversal of the tree before delete:"
    my_tree.postorder

    my_tree.delete(value)

    print "Postorder traversal of the tree after delete:"
    my_tree.postorder
  end
end
