class Solution:
    def isAnagram(self, s: str, t: str) -> bool:

        # Using Hashmap we can can create the count of each characters in the string and compare against each other to find if they are anagram

        if len(s) != len(t):
            return False
        countS, countT = {}, {}

        for i in range(len(s)):
            countS[s[i]] = 1 + countS.get(s[i], 0) # if key does not exists return 0 as value of key
            countT[t[i]] = 1 + countT.get(t[i], 0)

        for c in countS:
            if countS[c] != countT.get(c, 0):
                return False
        return True

        # Method -2 : Uinsg Sorted function to check if after sorting characters mathches at each place in s and t
        # return sorted(s) == sorted(t)

s = "aa"
t = "aa"
o = Solution()
print(o.isAnagram(s,t))

        # dict = {}
        # for key in s:
        #     if key in dict:
        #         val = dict.get(key)
        #         val+=1
        #         dict.update({key:val})
        #     else:
        #         dict[key] = 1

        # for char in t:
        #     if char not in dict:
        #         return False
        #     else:
        #         if dict[key]==0:
        #             dict.pop(key)
        #         else:
        #             dict.update({key:val-1})

        # return True



