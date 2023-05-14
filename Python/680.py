class Solution:
    def validPalindrome(self, s: str) -> bool:

        # if s == s[::-1]:
        #     return True

        # for i in range(len(s)):
        #     t = s[:i]+s[i+1:] 
        #     if t == t[::-1]:
        #         return True
        # return False             
            
    # Method- 2 Pointer
        l, r = 0, len(s) - 1

        while l < r:
            if s[l] != s[r]:
                skipL, skipR = s[l + 1:r + 1], s[l:r]
                return (skipL == skipL[::-1] 
                        or skipR == skipR[::-1])

            l, r = l + 1, r - 1
        
        return True

# !----
s = "aaaz"
p = Solution()
print(p.validPalindrome(s))