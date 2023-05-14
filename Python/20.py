class Solution:
    def isValid(self, s: str) -> bool:
        
        stack = []
        # Method 1:
        # for char in s:
        #     if char in ["(", "{", "["]:
        #         stack.append(char)
        #     else:
        #         if not stack:
        #             return False
                
        #         stack_lastchar = stack.pop()
        #         if stack_lastchar == "(":
        #             if char != ")":
        #                 return False
        #         if stack_lastchar == "{":
        #             if char != "}":
        #                 return False
        #         if stack_lastchar == "[":
        #             if char != "]":
        #                 return False
        
        # if stack:
        #     return False
        # return True

        # Method 2:
        closeToOpen = {")" : "(", "}" : "{", "]" : "["}

        for c in s:
            if c in closeToOpen:    
                if stack and stack[-1] == closeToOpen[c]:
                    stack.pop()
                else:
                    return False
            else:
                stack.append(c)
        
        return True if not stack else False
        

str = "()"
s = Solution()
print(s.isValid(str))

