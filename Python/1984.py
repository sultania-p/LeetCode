class Solution:
    def minimumDifference(self, nums, k: int) -> int:
        nums.sort()
        l, r = 0, k - 1
        res = float("inf")

        while r < len(nums):
            res = min(res, nums[r] - nums[l])
            l, r = l + 1, r + 1
        return res

'''
        i, j = 0, 0
        minVal = max(nums)
        

        if len(nums) <= 1:
            return 0

        for i in range(len(nums) - 1):
            for j in range(i+1, len(nums)):
                diff = abs(nums[i] - nums[j])
                if diff < minVal:
                    minVal = diff
        
        return minVal
'''

'''
        newSet = set(nums)
        newNums = sorted(list(newSet), reverse = True)
        diff_list = []
        minDiff = 0

        for x, y in zip(newNums[0:], newNums[1:]):
            diff_list.append(x - y)
        minDiff = diff_list[0]
'''

# !---
nums = [9, 4 , 1 ,7]
k = 2
p = Solution()
print(p.minimumDifference(nums, k))
