class Solution:
    def isPalindrome(self, s: str) -> bool:
        s= s.lower()

        forStr = ''.join(c for c in s if c.isalnum())
        revStr = ''.join(c for c in s[::-1] if c.isalnum())

        if forStr == revStr:
            return True
        return False


s = "1b1"
pal = Solution()
print(pal.isPalindrome(s))





