#!/usr/bin/env python
import RPi.GPIO as GPIO
import time
from array import *
pin_num = array('i',[11,12,13,15,16,18,22,29,31])
GPIO.setmode(GPIO.BOARD)
for n in range(0, 9):
	GPIO.setup(pin_num[n],GPIO.OUT)
	print "setup %d:GPIO %d" % (n,pin_num[n])
x = 0
while True:
	GPIO.output(pin_num[x],True)	
	print(x)
	time.sleep(0.5)
	GPIO.output(pin_num[x],False)
	time.sleep(0.5)
	x = x+1
	if (x == 9):
		x = 0

