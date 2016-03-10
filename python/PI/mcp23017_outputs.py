import smbus
import time

bus = smbus.SMBus(2) # BPi uses 2

DEVICE = 0x20 # Device address (A0-A2)
IODIRA = 0x00 # Pin direction register
OLATA  = 0x14 # Register for outputs
GPIOA  = 0x12 # Register for inputs

# Set all GPA pins as outputs by setting
# all bits of IODIRA register to 0
bus.write_byte_data(DEVICE,IODIRA,0x00)

# Set output all 7 output bits to 0
bus.write_byte_data(DEVICE,OLATA,0)
for x in range (1,10):
    for MyData in range(1,255):
      # Count from 1 to 8 which in binary will count 
      # from 001 to 111
      bus.write_byte_data(DEVICE,OLATA,MyData)
      print MyData
      time.sleep(0.01)
  
# Set all bits to zero
bus.write_byte_data(DEVICE,OLATA,0)
