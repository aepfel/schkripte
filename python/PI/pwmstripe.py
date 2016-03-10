import smbus
import time

bus = smbus.SMBus(2) # BPi uses 2

DEVICE = 0x20 # Device address (A0-A2)
IODIRA = 0x00 # Pin direction register
OLATA  = 0x14 # Register for outputs
GPIOA  = 0x12 # Register for inputs
timeouts = [100,100,100,100,100,100,100,100]
timeouts2 = [100,1,1,1,1,1,1,1]
timeouts3 = [100,100,100,100,100,100,100,100]

# Set all GPA pins as outputs by setting
# all bits of IODIRA register to 0
bus.write_byte_data(DEVICE,IODIRA,0x00)

def Clear():
    bus.write_byte_data(DEVICE,OLATA,0)


def BinCounter():
    clear()
    for MyData in range(1,255):
        bus.write_byte_data(DEVICE,OLATA,MyData)
        time.sleep(0.01)

def SetTimout(x,timeout):
    timeouts[x]=timeout

# array mit wertigkeiten und wann sie ausgeschaltet werden sollen 0=sofort 100=nie, schleife mit 100 durchlaeufen und sleepzeit von [berechnen}, 
# logik, die entscheidet, wenn eine wertigkeit ihre verfallszeit erreicht hat die neue zahl ueber den i2c zu senden
# setter fuer in modul globalem array, zweite globale variable, zum brechen der endlosschleife

data=0
for t in range(0,200):
    bus.write_byte_data(DEVICE,OLATA,data)
    for timeout in range(0,101):
        time.sleep(0.00001)
        for led in range(0,8):
            if (timeouts[led] == timeout): 
                data = data + pow(2,led)
                bus.write_byte_data(DEVICE,OLATA,data)
    data=0

data=0
for t in range(0,200):
    bus.write_byte_data(DEVICE,OLATA,data)
    for timeout in range(0,101):
        time.sleep(0.00001)
        for led in range(0,8):
            if (timeouts2[led] == timeout): 
                data = data + pow(2,led)
                bus.write_byte_data(DEVICE,OLATA,data)
    data=0

data=0
for t in range(0,200):
    bus.write_byte_data(DEVICE,OLATA,data)
    for timeout in range(0,101):
        time.sleep(0.00001)
        for led in range(0,8):
            if (timeouts3[led] == timeout): 
                data = data + pow(2,led)
                bus.write_byte_data(DEVICE,OLATA,data)
    data=0


#alles auf null setzen
Clear()
  

