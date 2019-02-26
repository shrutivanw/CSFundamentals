# A function takes two input parameters: potion size and an array of bottle sizes. 
# You may assume that you have an unlimited amount of bottles of each size.
# The function should return the minimum possible waste value for the given potion size. 
# e.g.
# Given potion size = 175
# and bottles = [70, 20, 30, 100]
# Then, the function should return 5, which is the minimum possible waste. (In this case by using 6 bottles of size 30)

def minimal_waste(potion_size, bottles) # return integer value of min waste
    return nil if bottles == nil || potion_size == nil || bottles.count < 1
    return recursive_helper(0, bottles, potion_size, bottles.max)
end

def recursive_helper(current_bottle, bottles, potion_size, min_waste)
    return min_waste if current_bottle == bottles.count # reached the end of bottles, return min_waste computed so far - no better solution

    if bottles[current_bottle] > potion_size # the current bottle has more in it that intended potion size
        # compute waste value by using just one of the current bottle
        waste = bottles[current_bottle] - potion_size
        if waste < min_waste
            min_waste = waste
        end

        # compute waste by skipping the current bottle and moving on with the rest of the bottles
        waste = recursive_helper(current_bottle + 1, bottles, potion_size, min_waste)
        return min_waste < waste ? min_waste : waste

    elsif bottles[current_bottle] < potion_size
        # compute for all possible values of 0 to n of current bottle alongside remaining bottles in the array
        while bottles[current_bottle] < potion_size
            waste = recursive_helper(current_bottle + 1, bottles, potion_size, min_waste)
            if waste < min_waste
                min_waste = waste
            end
            #puts "current: #{current_bottle}, min_waste: #{min_waste}, potion_size: #{potion_size}"
            potion_size -= bottles[current_bottle]
        end

        # loop terminates when the current bottle has more than equal to the amount in it as the potion size
        waste = bottles[current_bottle] - potion_size
        return min_waste < waste ? min_waste : waste
    end
    
    return 0 # potion_size == bottles[current_bottle]
end

puts "Expecting: 5, Actual: #{minimal_waste(175, [70, 20, 30, 100])}, params: 175, [70, 20, 30, 100]"
puts "Expecting: 0, Actual: #{minimal_waste(175, [70, 20, 30, 175, 100])}, params: 175, [70, 20, 30, 175, 100]"
puts "Expecting: 5, Actual: #{minimal_waste(35, [70, 20, 30, 175, 100])}, params: 35, [70, 20, 30, 175, 100]"
puts "Expecting: 3, Actual: #{minimal_waste(45, [70, 12, 30, 65, 100])}, params: 45, [70, 12, 30, 65, 100]"
puts "Expecting: 0, Actual: #{minimal_waste(123, [87, 23, 78, 10, 65])}, params: 123, [87, 23, 78, 10, 65]"
puts "Expecting: 7, Actual: #{minimal_waste(5, [70, 12, 30, 65, 100])}, params: 5, [70, 12, 30, 65, 100]"
puts "Expecting: 2, Actual: #{minimal_waste(67, [87, 23, 78, 10, 65])}, params: 67, [87, 23, 78, 10, 65]"
puts "Expecting: 3, Actual: #{minimal_waste(17, [5])}, params: 17, [5]"

