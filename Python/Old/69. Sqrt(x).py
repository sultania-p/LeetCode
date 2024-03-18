class Solution:
    def mySqrt(self, x: int) -> int:

        if x < 2:
            return x

        for i in range(0, x):
            if i * i == x:
                return i

            if i * i < x < (i+1) * (i+1):
                return i


if __name__ == '__main__':
    s = Solution()
    a = 0
    print(s.mySqrt(a))
