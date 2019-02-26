# Reference:
# https://techdevguide.withgoogle.com/paths/foundational/find-longest-word-in-DICTIONARYionary-that-subsequence-of-given-string/#code-challenge
# Find longest word in DICTIONARYionary that is a subsequence of a given string

## Approach
# Brute force approach
# Greedy: remove minimal possible number of characters and check
# Dictionary is a hash table for quick look up
# Optimal for: best chances of finding a word with minimum noise characters
# Not optimal for too many noise characters
# Space complexity:
#       - O(n) deep call stack
#       - O(n) for creating the new string to return
# Time complexity:
#         at the most O(2 ^ n) possible words looked up in the dictionary

# save D as a hash table to allow quick look ups i.e. O(1) time
DICTIONARY = {"at" => true, "apollo" => true, "able" => true, "all" => true, "toe" => true, "poll" => true, "toll" => true, "pole" => true}

# returns a new string with character at index remove_index removed from str
def remove_character(str, remove_index)
  temp = ""

  str.length.times do |i|
    if i != remove_index
      temp << str[i]
    end
  end
  return temp
end

# Removed count_to_remove number of characters from str via a recursive approach
# returns an empty string if no word is formed
def check_word(str, count_to_remove)
  if count_to_remove == 0 # base case - check if str forms a word
    if DICTIONARY[str]
      return str
    else
      return ""
    end
  end

  count_to_remove -= 1 # continue to remove one more charcter
  str.length.times do |i|
    # remove the character at index i
    temp = remove_character(str, i)
    ret = check_word(temp, count_to_remove)
    return ret if ret.length != 0
  end

  return ""
end


# greedy algorithm:
#             try the longest possible string, then the next longest and so on
def longest_subsequence(str)
  # return if input parameter is nil, empty or forms a complete word
  return str if str == nil || str.length == 0 || DICTIONARY[str] != nil

  len = str.length
  # remove minimum characters starting with 1 character
  # if it forms a word, return immediately and do not explore further
  (len-1).times do |i|
    ret = check_word(str, i+1)
    return ret if ret.length == len-i-1 # ret forms a word
  end

  return "" # no words found in str
end

puts "apollo return #{longest_subsequence("apollo")}"
puts "yapollo return #{longest_subsequence("yapollo")}"
puts "aypollo return #{longest_subsequence("aypollo")}"
puts "aypolklo return #{longest_subsequence("aypolklo")}"
puts "atplolklo return #{longest_subsequence("atplolklo")}"
puts "atploblklo return #{longest_subsequence("atploblklo")}"
puts "apolloz return #{longest_subsequence("apolloz")}"
puts "atplobllo return #{longest_subsequence("atplobllo")}"
puts "atploblloe return \"#{longest_subsequence("atploblloe")}\""
puts "z returns \"#{longest_subsequence("z")}\""
