print('***print names***')
class Recursion:
    def printNames(self, i, n):
        if (i > n):
            return;
        print("print Name");
        rec = Recursion();
        rec.printNames(i+1, n);

rec = Recursion()
rec.printNames(2, 4)

print('****print numbers 1->N*****')
def printNumbers(i, n):
    if (i > n):
        return; 
    print("print Number " + str(i))
    printNumbers(i+1, n)
printNumbers(1, 3)

print('***print numbers N->1****')
def printReverseNumbers(i, n):
    if (i < 1):
        return;
    print("print Number " + str(i));
    printReverseNumbers(i-1, n)
printReverseNumbers(4, 2)

print('***print numbers using Backtracking')
def printNumbersBacktracking(i, n):
    if (i < n):
        return
    

