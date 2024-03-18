class Solution:
    def removeElement(self, nums, val: int) -> int:

        l = 0
        for r in range(0, len(nums)):
            if nums[r] != val:
                nums[l] = nums[r]
                l += 1

        return l


if __name__ == '__main__':
    s = Solution()
    nums = [0, 1, 2, 2, 3, 0, 4, 2]
    val = 2
    print(s.removeElement(nums, val))
