#!/usr/bin/python
# simmuliert monty-hall-phaenomen. (drei tueren, hinter einer gewinn, die ohne gewinn wird 
# geoeffnet, dann gewechselt, wie ist wahrscheinlichkeit?)

import random

numdoors = 10
numtests = 99999
win = 0
lose = 0
print("doing " + str(numtests) + " runs with " + str(numdoors) + " doors.")
print("expecting " + str(numtests/(numdoors -1)) + " loses.")
for i in range(0, numtests): 
    choice = random.randrange(0,numdoors - 1) #choose wich door to initaly take
    car = random.randrange(0,numdoors - 1) #choose wich door houses car
# preparation done. you have choosen one door and car is hidden behind one door
# monty now opens all doors except your choosen, the car hidding one and eventually 
# a random door (in case your choice was right)
    if choice == car: # lost, since your next move is to swap doors
        lose += 1
    else:
        win += 1
print("Wins:" + str(win))
print("Loses:" + str(lose))
