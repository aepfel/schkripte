import smbus
import time
from math import exp
bus=smbus.SMBus(2)
address=0x20
bus.write_byte_data(address,0x0c,0xff) #pullup aktivieren
bus.write_byte_data(address,0x0d,0xff) #pullup aktivieren
while True:
	y=2
	for x in xrange(1):
		bus.write_byte_data(address,1,pow(2,x))
		time.sleep(5)
	while y > 1:
		y = y-1
		bus.write_byte_data(address,1,pow(2,y))
		time.sleep(5)
		
