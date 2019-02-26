# Reference: https://leetcode.com/problems/zigzag-conversion/
# The string "PAYPALISHIRING" is written in a zigzag pattern on a given number
# of rows like this: (you may want to display this pattern in a fixed font
# for better legibility)
# P   A   H   N
# A P L S I I G
# Y   I   R
# And then read line by line: "PAHNAPLSIIGYIR"
# Write the code that will take a string and make this conversion given a number of rows:
# string convert(string s, int numRows);
# Example 1:
# Input: s = "PAYPALISHIRING", numRows = 3
# Output: "PAHNAPLSIIGYIR"
# Example 2:
# Input: s = "PAYPALISHIRING", numRows = 4
# Output: "PINALSIGYAHRPI"
# Explanation:

# P     I    N
# A   L S  I G
# Y A   H R
# P     I

def convert(s, num_rows)
  return s if s == nil || num_rows == nil || s.length <= 1 || num_rows <= 1

  # approach: create a matrix with num_rows and columns
  # keep track of whether going down or up
  # append the character to the appropriate row
  # with Ruby, we can leverage .push method
  # with strongly typed language and array of primitive type, character,
  # we will need to keep track of which column we are on for each row.
  downwards = true
  matrix = Array.new(num_rows){Array.new(s.length)}

  # approach that'd work with non Ruby lanaguages
  column_index = Array.new(num_rows)
  num_rows.times do |row|
    column_index[row] = 0
  end

  current_row = 0
  s.length.times do |i|
    matrix[current_row][column_index[current_row]] = s[i]
    column_index[current_row] += 1
    if downwards
      if current_row == num_rows - 1
        downwards = false
        current_row -= 1
      else # keep moving to the next row down
        current_row += 1
      end
    else # upwards
      if current_row == 0
        downwards = true
        current_row += 1
      else # keep moving to the next row up
        current_row -= 1
      end
    end
  end

  output_string = "" # create an output string with same length as input string
  i = 0
  num_rows.times do |j|
    column_index[j].times do |k|
      output_string[i] = matrix[j][k]
      i += 1
    end
  end

  return output_string
end

puts "PAYPALISHIRING: #{convert("PAYPALISHIRING", 3)}"
puts "PAYPALISHIRING: #{convert("PAYPALISHIRING", 4)}"

