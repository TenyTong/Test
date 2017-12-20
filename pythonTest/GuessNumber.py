# xml version="1.0" encoding="UTF-8"
__author__ = 'tong.li'

import random

guess_munber = random.randint(0,100)
print("The targer number is : ",guess_munber)

guess_one = 0
min=0
max=100
while ( guess_one != guess_munber):
    guess_one = int(input("Please input the guess number in ["+str(min)+" "+str(max)+"]:\n"))
    if(guess_one>min) and (guess_one<guess_munber):
        print("less")
        min = guess_one
    elif(guess_one>guess_munber) and (guess_one<max):
        print("more")
        max = guess_one
    elif(guess_one == guess_munber):
        print("Congratulations!")
    else:
        print("bad input!")