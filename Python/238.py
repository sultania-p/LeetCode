def productExceptSelf(nums):
    ln = len(nums)
    nums2 = []
    prod = 1
    for i in range(0, ln):
        nums1 = nums[:i] + nums[i+1:]
        print(nums1)
        for j in nums1:
            prod = prod * j
        nums2.append(prod)
        prod =1
    return nums2

nums = [-1,1,0,-3,3]
answer = productExceptSelf(nums)
print(answer)