class Solution:
    def replaceElements(self, arr):
        rightMax = -1

        for i in range(len(arr) - 1, -1, -1):
            newMax = max(arr[i], rightMax)
            arr[i] = rightMax
            rightMax = newMax


        return arr

arr = [17,18,5,4,6,1]
s = Solution()
print(s.replaceElements(arr))
