class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        
        l, r = 0, len(nums) - 1
        
        while l <= r:
            mid = (l + r) // 2
            
            if nums[mid] == target:
                return mid
            
            if nums[mid] < target:
                l = mid + 1
            else:
                r = mid - 1
                
        return l
            
        
        
        
#         i = 0

#         if target > max(nums):
#             return len(nums)

#         while nums[i] <= target:
#             if nums[i] == target:
#                 return i

#             i += 1
#         return i