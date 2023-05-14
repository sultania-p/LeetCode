class Solution:
    def maxProfit(self, prices) -> int:
        
        # # Brute Force Approach (TLE)
        # max_profit = 0
        
        # for i in range(0, len(prices)-1):
        #         for j in range(i+1, len(prices)):
        #             profit = prices[j] - prices[i]
        #             if profit > max_profit:
        #                 max_profit = profit

        # return max_profit

        # l - Buy, r - Sell
        l, r = 0, 1
        maxProfit = 0

        while r < len(prices):
            if prices[l] < prices[r]:
                profit = prices[r] - prices[l]
                maxProfit = max(profit, maxProfit)
            else:
                l = r
            r += 1
        return maxProfit

prices = [7,1,5,3,6,4]
s = Solution()
print(s.maxProfit(prices))