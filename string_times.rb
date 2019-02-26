# reference: https://codingbat.com/prob/p193507
# Given a string and a non-negative int n, return a larger string that is n copies of the original string.
# string_times('Hi', 2) → 'HiHi'
# string_times('Hi', 3) → 'HiHiHi'
# string_times('Hi', 1) → 'Hi'

# Space complexity: for new_str, O(n * m) where n is the input parameter value, m is the length of the string
# Time complexity: to copy each character from input string n number of times: O(n * m) where n is the input parameter value, m is the length of the string
def string_times(str, n)
  new_str = ""
  n.times do
    new_str << str
    # str.length.times do |i|
    #   new_str << str[i]
    # end
  end
  return new_str
end

puts string_times("Hi", 2)
puts string_times("Hi", 3)
puts string_times("Hi", 1)