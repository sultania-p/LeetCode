class Solution:
    def containsDuplicate(self, nums) -> bool:

        hashset = set()

        for n in nums:
            if n in hashset:
                return True
            else:
                hashset.add(n)
        return False
        

nums = [1,2,3,4,1]
s = Solution()
print(s.containsDuplicate(nums))