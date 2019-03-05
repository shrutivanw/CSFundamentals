# if the input string is "abc", 
# then, the method will print: "a", "b", "c", "ab", "bc", "abc"
# if the input string is "abcd", 
# then, the method will print: "a", "b", "c", "d", "ab", "bc", "cd", "abc", "bcd", "abcd"


def print_combinations(str)
    return if !str || str.length == 0
    str_length = str.length
    char_count = 1
    while char_count <= str_length
        start_index = 0
        print_current(start_index, char_count, str, str_length)
        char_count += 1
    end
    return
end

def print_current(start_index, char_count, str, str_length)
    return if start_index + char_count > str_length
    
    i = 0
    while i < char_count
        print str[start_index + i]
        i += 1
    end
    puts
    
    print_current(start_index + 1, char_count, str, str_length)
 end

print_combinations("abcd") # => "a", "b", "c", "ab", "ac", "bc", "abc"
