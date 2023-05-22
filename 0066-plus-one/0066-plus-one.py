class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        s = ''
        res = []
        for i in digits:
            s = s + str(i)

        n = str(int(s) + 1)
        for i in n:
            res.append(int(i))

        return res