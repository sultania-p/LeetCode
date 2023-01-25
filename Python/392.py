class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        
    # Method - Stack
        # stack = list(s)

        # for char in t:
        #     if stack and stack[0] == char:
        #         stack.pop(0)
                
        # return True if not stack else False        

    # Method - 2 Pointer
        i, j = 0, 0

        while i < len(s) and j < len(t):
            if s[i] == t[j]:
                i += 1
            j += 1

        return True if i == len(s) else False




# ---
s = "abc"
t = "ahbgdc"
o = Solution()
print(o.isSubsequence(s, t))