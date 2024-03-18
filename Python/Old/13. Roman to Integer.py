class Solution:
    def romanToInt(self, s: str) -> int:
        '''
            n = 0
            for i in range(0, len(s)):
                if s[i] == 'I':
                    n += 1
                elif s[i] == 'V':
                    n += 5
                elif s[i] == 'X':
                    n += 10
                elif s[i] == 'L':
                    n += 50
                elif s[i] == 'C':
                    n += 100
                elif s[i] == 'D':
                    n += 500
                elif s[i] == 'M':
                    n += 1000

            if 'IV' or 'IX' in str:
                n -= 2
            elif 'XL' or 'XC' in str:
                n -= 20
            elif 'CD' or 'CM' in str:
                n -= 200

            return n    
        '''

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
            if i+1 < len(s) and set[s[i]] < set[s[i+1]]:
                total += set[s[i]] * -1
            else:
                total += set[s[i]]
            i += 1

        return total


if __name__ == '__main__':
    s = Solution()
    print(s.romanToInt('MCMXCIV'))
