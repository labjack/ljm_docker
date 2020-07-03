import datetime
import os

from labjack import ljm

print(str(datetime.datetime.now()))
results = ljm.ljm.listAll(ljm.constants.dtANY, ljm.constants.ctANY)
print("Found %d connections" % results[0])
