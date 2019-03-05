# Question: Design and author a method that takes a string of distinct characters as a string and prints all possible combinations of the characters in the string.
# e.g. 
# if the input string is "abc", 
# then, the method will print: "a", "b", "c", "ab", "ac", "bc", "abc"
# Note: "ab" or "ba" are considered the same combination for this assignment.

def print_combinations(str)
    return if !str || str.length == 0 # nil or empty

    str_length = str.length
    char_count = 1 # minimum output string length
    while char_count <= str_length # from minimum to maximum output length
        # print all combinations with char_count number of characters
        print_current(0, char_count, str, str_length, "")
        # puts "#{char_count} complete"
        char_count += 1
    end
    return
end

def print_current(i, char_count, str, str_length, output)
    if char_count == 0 || i == str_length
        puts output
        return
    end

    # choose to print current char
    print_current(i+1, char_count-1, str, str_length, output + str[i])

    # choose to not print current char, if possible
    if str_length - char_count - i > 0
        print_current(i+1, char_count, str, str_length, output)
    end
end

print_combinations("abcd") 
# => "a", "b", "c", "d", "ab", "ac", "ad", "bc", "bd", "cd", "abc", "acd", "abd", "bcd", "abcd"
