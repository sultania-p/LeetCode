# class Solution:
#     def sumOddLengthSubarrays(self, arr) -> int:
#         n = len(arr)
#         answer = 0
        
#         for i, a in enumerate(arr):
#             left, right = i, n - i - 1
#             answer += a * (left // 2 + 1) * (right // 2 + 1)
#             answer += a * ((left + 1) // 2) * ((right + 1) // 2)
#         return answer
    
# l = Solution()
# print(l.sumOddLengthSubarrays([2,3,10,7]))

# def OddLengthSum(arr):
	
# 	# Stores the sum
# 	sum = 0

# 	# Size of array
# 	l = len(arr)

# 	# Traverse the array
# 	for i in range(l):

# 		# Generate all subarray of
# 		# odd length
# 		for j in range(i, l, 2):
# 			for k in range(i, j + 1, 1):

# 				# Add the element to sum
# 				sum += arr[k]
			
# 	# Return the final sum
# 	return sum

# # Driver Code

# # Given array arr[]
# arr = [ 2,3,10,7 ]

# # Function call
# print(OddLengthSum(arr))

def sumOddLengthSubarrays(arr) -> int:
    n = len(arr)
    answer = 0

    for i in arr:
        answer = answer+i
        for j in range()


    
    for left in range(n):
        for right in range(left, n):
            if (right - left + 1) % 2 == 1:
                current_sum = 0
                for index in range(left, right + 1):
                    current_sum += arr[index]
                answer += current_sum

    return answer

arr = [ 2,3,10,7 ]
print(sumOddLengthSubarrays(arr))