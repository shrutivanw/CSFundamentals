require_relative "../LinkedLists/linked_list"

class Queue
    def initialize()
        @inner_list = LinkedList.new()
    end

    def enqueue(value)
        @inner_list.insert(value)
    end

    def dequeue()
        return @inner_list.remove_tail()
    end

    def is_empty()
        return @inner_list.length == 0
    end

    # for debugging
    def print()
        @inner_list.visit
    end
end

my_queue = Queue.new()
puts "Is the queue empty? #{my_queue.is_empty}"

puts "enqueue 10"
my_queue.enqueue(10)
puts "Is the queue empty? #{my_queue.is_empty}"

puts "enqueue 20"
my_queue.enqueue(20)
puts "Is the queue empty? #{my_queue.is_empty}"

puts "enqueue 30"
my_queue.enqueue(30)
puts "Is the queue empty? #{my_queue.is_empty}"

puts "dequeue should return 10: #{my_queue.dequeue()}"
puts "Is the queue empty? #{my_queue.is_empty}"
puts "dequeue should return 20: #{my_queue.dequeue()}"
puts "Is the queue empty? #{my_queue.is_empty}"
puts "dequeue should return 30: #{my_queue.dequeue()}"
puts "Is the queue empty? #{my_queue.is_empty}"
my_queue.print()
