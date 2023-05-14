class Solution:
    def isPalindrome(self, x: int) -> bool:
        y = str(x)
        if len(y) == 1:
            return True

        if y[::-1] == y:
            return True

        return False


if __name__ == '__main__':
    s = Solution()
    print(s.isPalindrome(123))
