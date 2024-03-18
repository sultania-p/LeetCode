class Solution:
    def longestCommonPrefix(self, strs):

        common = ""
        for i in range(len(strs[0])):
            for s in strs:
                if i == len(s) or strs[0][i] != s[i]:
                    return common

            common += strs[0][i]
        return common


if __name__ == '__main__':
    s = Solution()
    strs = ["flower", "flow", "flight"]
    print(s.longestCommonPrefix(strs))
