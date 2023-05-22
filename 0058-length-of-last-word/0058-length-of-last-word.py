class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        list = []
        words = s.split(" ")
        
        for word in words:
            if word != '':
                list.append(word)
        
        return (len(list[-1]))