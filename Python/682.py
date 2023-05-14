class Solution:
    def calPoints(self, operations) -> int:
        i = 0
        stack = []

        while i < len(operations):
            if operations[i] == "+":
                stack.append(stack[-1] + stack[-2])
            elif operations[i] == "D":
                stack.append(2 * stack[-1])
            elif operations[i] == "C":
                stack.pop()
            else:
                stack.append(int(operations[i]))
            i += 1
        
        return sum(stack)

# !---
ops = ["1","C"]
s = Solution()
print(s.calPoints(ops))