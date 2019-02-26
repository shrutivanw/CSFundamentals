# Reference: https://codingbat.com/prob/p117334
# Given a non-empty string like "Code" return a string like "CCoCodCode".
# stringSplosion("Code") → "CCoCodCode"
# stringSplosion("abc") → "aababc"
# stringSplosion("ab") → "aab"

# Time complexity: O(1 + 2 + 3 + ... + n) = O(n * (n+1)/2) = O(n^2)
# Space complexity: new_str of length O(n^2), recursion: n deep => O(n^2)
def splosion_helper(new_str, str, current_index, length)
  current_index += 1
  current_index.times do |i|
    new_str << str[i]
  end
  if current_index != length
    splosion_helper(new_str, str, current_index, length)
  end
  return
end

def string_splosion(str)
  new_str = ""
  splosion_helper(new_str, str, 0, str.length)
  return new_str
end



puts string_splosion("Code")
puts string_splosion("abc")
puts string_splosion("ab")
puts string_splosion("I")