# Reference: https://leetcode.com/problems/median-of-two-sorted-arrays/
# There are two sorted arrays nums1 and nums2 of size m and n respectively.
# Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

# Helper method that computes the median of a single integer array
def find_median(nums)
    len = nums.length
    if len % 2 == 0
        median = (nums[(len)/2] + nums[(len)/2 - 1]).to_f/2
    else
        median = nums[(len)/2].to_f
    end

    return median
end

# You may assume nums1 and nums2 cannot be both empty.
# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
    if nums1.length == 0
        return find_median(nums2)
    elsif nums2.length == 0
        return find_median(nums1)
    else
        total_length = nums1.length + nums2.length

        if nums1.length <= nums2.length
            small = nums1
            large = nums2
            small_len = nums1.length
            large_len = nums2.length
        else
            small = nums2
            large = nums1
            small_len = nums2.length
            large_len = nums1.length
        end

        # binary search on small array
        low = 0
        high = small_len - 1
        mid = 0
        pivot = 0
        while low <= high
            mid = (low + high)/2
            pivot = ((total_length + 1) / 2) - mid - 1

            if pivot > 0 && mid < high && large[pivot-1] > small[mid+1]
                low = mid + 1
            elsif mid > 0 && small[mid] > large[pivot]
                high = mid - 1
            else
                break
            end
        end

        # compute median around mid and pivot
        if total_length % 2 != 0
            # decide between mid, mid+1, pivot and pivot-1
            if small[mid] < large[pivot] && large[pivot-1] < small[mid]
                median = small[mid].to_f
            elsif small[mid] < large[pivot-1]
                median = large[pivot-1].to_f
            else
                median = large[pivot].to_f
            end
        else
            # puts "#{mid}, #{pivot}"
            if mid == (small_len -1) && mid == 0 # only one element in the smaller array
                if small[mid] >= large[pivot]
                    if pivot < large_len - 1 && small[mid] > large[pivot+1]
                        median = ((large[pivot+1]+large[pivot]).to_f)/2
                    else
                        median = ((large[pivot]+small[mid]).to_f)/2
                    end
                elsif pivot > 0 && small[mid] <= large[pivot-1]
                    median = ((large[pivot-1]+large[pivot]).to_f)/2
                else
                    median = ((large[pivot]+small[mid]).to_f)/2
                end
            else
                if small[mid] > large[pivot]
                    if pivot < large_len - 1 && small[mid] > large[pivot+1]
                        median = ((large[pivot+1]+large[pivot]).to_f)/2
                    elsif pivot == large_len - 1
                        median = ((small[mid]+large[pivot]).to_f)/2
                    else
                        median = ((small[mid]+large[pivot]).to_f)/2
                    end
                elsif pivot > 0 && mid < (small_len -1)
                    if small[mid+1] < large[pivot]
                        if small[mid] > large[pivot-1]
                            median = ((small[mid]+small[mid+1]).to_f)/2
                        else
                            median = ((small[mid+1]+large[pivot-1]).to_f)/2
                        end
                    elsif small[mid] > large[pivot]
                        median = ((large[pivot-1] + large[pivot]).to_f)/2
                    else
                        lower = small[mid] < large[pivot-1] ? large[pivot-1] : small[mid]
                        higher = small[mid+1] < large[pivot] ? small[mid+1] : large[pivot]
                        median = ((lower+higher).to_f)/2
                    end

                # elsif pivot > 0 && mid < (small_len -1) && large[pivot-1] <= small[mid] && small[mid+1] <= large[pivot]
                #     median = ((small[mid]+small[mid+1]).to_f)/2
                # elsif pivot > 0 && mid < (small_len -1) && small[mid] <= large[pivot-1] && large[pivot] <= small[mid+1]
                #     median = ((large[pivot-1] + large[pivot]).to_f)/2
                # elsif pivot > 0 && mid < (small_len -1) && (small[mid] <= large[pivot-1] && large[pivot-1] <= small[mid+1])
                #     median = ((small[mid+1]+large[pivot-1]).to_f)/2
                # elsif mid == (small_len -1) && pivot > 0
                #     if small[mid] <= large [pivot-1]
                #         median = ((large[pivot-1] + large[pivot]).to_f)/2
                #     elsif small[mid] >= large[pivot] && pivot <= large_len && small[mid] < large[pivot+1]
                #         median = ((large[pivot+1]+large[pivot]).to_f)/2
                #     else
                #         median = ((small[mid]+large[pivot]).to_f)/2
                #     end
                else
                    median = ((small[mid]+large[pivot]).to_f)/2
                end
            end


            # if pivot > 0 && small[mid] < large[pivot] && large[pivot-1] < small[mid]
            #     if mid < high && small[mid+1] <= large[pivot]
            #         median = ((small[mid]+small[mid+1]).to_f)/2
            #     else
            #         median = ((small[mid]+large[pivot-1]).to_f)/2
            #     end
            # elsif pivot > 0 && small[mid] <= large[pivot-1]
            #     if mid < high && small[mid+1] < large[pivot]
            #         median = ((small[mid+1]+large[pivot-1]).to_f)/2
            #     else
            #         median = ((large[pivot-1] + large[pivot]).to_f)/2
            #     end
            # else
            #     median = ((small[mid]+large[pivot]).to_f)/2
            # end
            # if pivot == 0
            #     temp1 = small[mid].to_f
            # else
            #     temp1 = (small[mid] < large[pivot-1] ? large[pivot-1] : small[mid]).to_f
            # end

            # if mid == high
            #     temp2 = large[pivot].to_f
            # else
            #     temp2 = (small[mid+1] < large[pivot] ? small[mid+1] : large[pivot]).to_f
            # end
            # median = (temp1 + temp2)/2
        end

        return median
    end
end

nums1 = [1, 3]
nums2 = [2]
puts "Expected: 2.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2]
nums2 = [3, 4]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 3, 5]
nums2 = [2, 4]
puts "Expected: 3.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 3, 5]
nums2 = [2, 4, 6]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [2, 4, 5, 6]
nums2 = [1]
puts "Expected: 4.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2, 5]
nums2 = [4]
puts "Expected: 3.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2, 5]
nums2 = []
puts "Expected: 2.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = []
nums2 = [2, 5]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1]
nums2 = [3]
puts "Expected: 2.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [3]
nums2 = [1]
puts "Expected: 2.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [-2, -1]
nums2 = [3]
puts "Expected: -1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [3]
nums2 = [-2, -1]
puts "Expected: -1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [-2, -1]
nums2 = [3, 8]
puts "Expected: 1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [3, 8]
nums2 = [-2, -1]
puts "Expected: 1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1]
nums2 = [2, 3, 4]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2]
nums2 = [-1, 3]
puts "Expected: 1.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 1]
nums2 = [1, 2]
puts "Expected: 1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2]
nums2 = [1, 1]
puts "Expected: 1.0, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1]
nums2 = [2, 3, 4]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [2, 3, 4]
nums2 = [1]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [4]
nums2 = [1, 2, 3]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2, 3]
nums2 = [4]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [5, 6]
nums2 = [1, 2, 3, 4]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 2, 3, 4]
nums2 = [5, 6]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 3]
nums2 = [2, 4]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums2 = [2, 4]
nums1 = [1, 3]
puts "Expected: 2.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [4, 5]
nums2 = [1, 2, 3, 6]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

nums1 = [1, 4, 5]
nums2 = [2, 3, 6]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"

puts "[1, 2] and [3, 4, 5, 6]"
num1 = [1, 2]
num2 = [3, 4, 5, 6]
puts "Expected: 3.5, Actual: #{find_median_sorted_arrays(nums1, nums2)}"