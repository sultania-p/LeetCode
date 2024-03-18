def getCumulativeSum(arr):
		# add your logic here
    arr1 = []
    for i in range(0,len(arr)):
        if i==0:
            arr1.append(arr[i])
        else:
            arr1.append(arr[i]+arr1[i-1])
    return arr1

arr= [1, 3, 5, 7, 9]
print(getCumulativeSum(arr))