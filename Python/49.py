from collections import defaultdict

class Solution:
    def groupAnagrams(self, strs):
        
        # res = defaultdict(list)
        # for s in strs:
        #     count = [0] * 26
        #     for c in s:
        #         count[ord(c) - ord("a")] += 1
        #     res[tuple(count)].append(s)

        # return res.values()

        # Method-2
        lookup = defaultdict(list)

        for s in strs:
            key = ''.join(sorted(list(s)))
            lookup[key].append(s)

            output = []
            for l in lookup.values():
                output.append(l)

        return output



strs = ["eat","tea","tan","ate","nat","bat"]
s = Solution()
print(s.groupAnagrams(strs))