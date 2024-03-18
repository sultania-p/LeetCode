class Solution:
    def removeDuplicates(self, nums):
        '''
        # cannot use stack in-place process
        stack = []
        k = 0
        for i in range(len(nums)):
            if nums[i] in stack:
                stack.pop
            else:
                stack.append(nums[i])
                k += 1

        nums = stack
        return k
        '''

        l = 1

        for r in range(1, len(nums)):
            if nums[r] != nums[r - 1]:
                nums[l] = nums[r]
                l += 1

        return l


if __name__ == '__main__':
    s = Solution()
    nums = [1, 1, 2]
    print(s.removeDuplicates(nums))
