require_relative "../LinkedLists/linked_list"

class Stack
    def initialize()
        @inner_list = LinkedList.new()
    end

    def push(value)
        @inner_list.insert(value)
    end

    def pop()
        return @inner_list.remove_head()
    end

    def is_empty()
        return @inner_list.length == 0
    end

    # for debugging
    def print()
        @inner_list.visit
    end
end

my_stack = Stack.new()
puts "Is the queue empty? #{my_stack.is_empty}"

puts "push 10"
my_stack.push(10)
puts "Is the queue empty? #{my_stack.is_empty}"

puts "push 20"
my_stack.push(20)
puts "Is the queue empty? #{my_stack.is_empty}"

puts "push 30"
my_stack.push(30)
puts "Is the queue empty? #{my_stack.is_empty}"

puts "pop should return 30: #{my_stack.pop()}"
puts "Is the queue empty? #{my_stack.is_empty}"
puts "pop should return 20: #{my_stack.pop()}"
puts "Is the queue empty? #{my_stack.is_empty}"
puts "pop should return 10: #{my_stack.pop()}"
puts "Is the queue empty? #{my_stack.is_empty}"
my_stack.print()

