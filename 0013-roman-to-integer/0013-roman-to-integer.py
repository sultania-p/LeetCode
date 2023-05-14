class Solution:
    def romanToInt(self, s: str) -> int:
        
        # create a hashmap
        set = {
            'I': 1,
            'V': 5,
            'X': 10,
            'L': 50,
            'C': 100,
            'D': 500,
            'M': 1000
        }

        total = 0
        i = 0
        for i in range(len(s)):
            # check if the last index is not getting out of bound
            if i+1 < len(s) and set[s[i]] < set[s[i+1]]:
                total += set[s[i]] * -1
                # print(total)
            else:
                total += set[s[i]]
                # print(total)
            i += 1

        return total