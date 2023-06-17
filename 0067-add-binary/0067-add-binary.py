class Solution:
    def addBinary(self, a: str, b: str) -> str:
        carry = 0
        a = a[::-1]  # 0101
        b = b[::-1]  # 1101

        res = ''    # 10101

        for i in range(max(len(a), len(b))):

            digitA = int(a[i]) if i < len(a) else 0
            digitB = int(b[i]) if i < len(b) else 0

            total = digitA + digitB + carry
            char = str(total % 2)

            res = char + res
            carry = total // 2
            # print(digitA, digitB, total, char, carry)

        if carry:
            res = "1" + res
        return res