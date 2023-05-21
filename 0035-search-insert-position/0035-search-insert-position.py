class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        i = 0

        if target > max(nums):
            return len(nums)

        while nums[i] <= target:
            if nums[i] == target:
                return i

            i += 1
        return i