class Solution:
    def searchInsert(self, nums, target: int) -> int:

        i = 0

        if target > max(nums):
            return len(nums)

        while nums[i] <= target:
            if nums[i] == target:
                return i

            i += 1
        return i


if __name__ == '__main__':
    s = Solution()
    nums = [1, 3, 5, 6]
    target = 7
    print(s.searchInsert(nums, target))
