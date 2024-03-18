class Solution:
    def strStr(self, haystack: str, needle: str) -> int:

        if len(needle) > len(haystack):
            return -1

        for i in range(len(haystack) - len(needle) + 1):
            if haystack[i: i + len(needle)] == needle:
                return i

        return -1


if __name__ == '__main__':
    s = Solution()
    haystack = "sadbutsad"
    needle = "sad"
    print(s.strStr(haystack, needle))
