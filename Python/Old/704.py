class Solution:
    def search(self, nums, target: int) -> int:
        low, high = 0, len(nums) - 1

        # if len(nums) == 1 and nums[0] == target:
        #     return 0

        while low <= high:
            mid = (low + high) // 2

            if nums[mid] == target:
                return mid
            elif nums[mid] > target:
                high = mid - 1
            elif nums[mid] < target:
                low = mid + 1
            
        return -1
    
# !---
nums = [2,5]
target = 5
s = Solution()
print(s.search(nums, target))





