class Solution:
    def lengthOfLastWord(self, s: str) -> int:

        lastWord = []
        lWords = s.split(" ")

        for word in lWords:
            if word != '':
                lastWord.append(word)

        return len(lastWord[-1])

# !---
s = "luffy is still joyboy"
p = Solution()
print(p.lengthOfLastWord(s))
