class Solution:
    def plusOne(self, digits) -> list:

        # [1, 2, 9]
        # [1, 3, 0]

        res = digits
        if len(digits) > 1:
            if res[-1] == 9:
                res[-2] += 1
                res[-1] = 0
            else:
                res[-1] += 1
        else:
            n = str(res[0] + 1)
            res = []
            for i in n:
                res.append(int(i))

        print(res)

        # s = ''
        # res = []
        # for i in digits:
        #     s = s + str(i)

        # n = str(int(s) + 1)
        # for i in n:
        #     res.append(int(i))

        # return res


if __name__ == '__main__':
    s = Solution()
    digits = [0]
    print(s.plusOne(digits))
