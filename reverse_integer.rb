# Reference: https://leetcode.com/problems/reverse-integer/
# Given a 32-bit signed integer, reverse digits of an integer.
# Example 1:
# Input: 123
# Output: 321
# Example 2:
# Input: -123
# Output: -321
# Example 3:
# Input: 120
# Output: 21
# Note: Assume we are dealing with an environment which could only store
# integers within the 32-bit signed integer range: [−231,  231 − 1]. For the
# purpose of this problem, assume that your function returns 0 when the reversed
# integer overflows.


# -2 ^ 31 to 2 ^ 31

# @param {Integer} x
# @return {Integer}
def reverse(x)
  return x if x < 10 && x > 10 # single digit

  temp = x
  multiplier = 1
  max_value = (2 ** 31) - 1
  if temp < 0
    temp = temp * -1
    multiplier = -1
    max_value = 2 ** 31
  end

  # find the number of digits in temp
  power_of_ten = 1
  temp1 = temp
  while temp1 >= 10
    power_of_ten *= 10
    temp1 = temp1 / 10
  end

  reversed = 0
  while power_of_ten >= 10
    return 0 if (reversed > max_value || reversed < 0)
    reversed += ((temp % 10) * power_of_ten)
    temp /= 10
    power_of_ten /= 10
  end
  reversed += temp
  return 0 if (reversed > max_value || reversed < 0)

  return reversed * multiplier 
end

# puts "123 in reverse is #{reverse(123)}"
# puts "-123 in reverse is #{reverse(-123)}"
# puts "120 in reverse is #{reverse(120)}"
# puts "5 in reverse is #{reverse(5)}"
# puts "-7 in reverse is #{reverse(-7)}"
# puts "0 in reverse is #{reverse(0)}"
# puts "2001 in reverse is #{reverse(2001)}"
puts "10 in reverse is #{reverse(10)}"