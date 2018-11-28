# Program that accepts command line parameter as input string
# All permutations of the input string are saved in an array
# All values in the array are the printed

# helper method
# Swaps the characters at index1 and index2 in the input string, str
def swap(str, index1, index2)
  temp = str[index1]
  str[index1] = str[index2]
  str[index2] = temp
  return
end

# Recursive method to save all permutations of the string in an array
# Space complexity: O(n + (n * n!)) = O(n!)
# Call stack: O(n) where n is the number of characters in the input string
#       base case is reached when start_index and end_index are equal
#       at this point, before the stack starts unwinding,
#       there will be n records on the call stack
# my_array: O(n * n!) where n is the number of characters in the input string
#   after all the recursive calls, my_array will have n! elements, each n length long
#
# Time complexity: n! where n is the number of characters in the input string
#   the first time the function is called, while loop runs n times
#   from each iteration of the loop from this first call, a recursive call is made
#   -> within this recursive call, the loop runs (n-1)
#   -> in each iteration, once again a recursive call is made
#  and so on until the loop is not entered i.e. start_index is equal to end_index
# n * (n-1) * (n-2) *... * 2 * 1 = n!
def print_all_permutations(str, start_index, end_index, my_array)
  if start_index == end_index # base case
    # found a complete permutation
    # add it to the array
    my_array << str.dup
  else # recursive case
    i = start_index
    # loop to:
    # 1. consider each of remaining characters (from start_index to end_index) to be at index
    # 2. recursively call method with start_index + 1
    while i <= end_index
      # swap character at start_index with character at i
      swap(str, i, start_index)
      # permute starting at index following the start_index
      print_all_permutations(str, start_index+1, end_index, my_array)
      # backtrack to previous state
      # i.e. unswap character at start_index with character at i
      swap(str, i, start_index)
      i += 1
    end
  end
end

# main logic
# take the argument from command line and duplicate it so it's mutable
str = ARGV[0].to_s.dup
# create an array to hold all permutations
my_array = Array.new()
# call the recursive method
print_all_permutations(str, 0, str.length-1, my_array)
# print all strings in the array
my_array.each do |str|
  puts str
end
