class Solution:
    def isPalindrome(self, x: int) -> bool:
        y = str(x)
        if len(y) == 1:
            return True

        if y[::-1] == y:
            return True

        return False