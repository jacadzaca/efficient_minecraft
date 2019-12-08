#!/bin/sh
HEAP_SIZE=2096

NURSERY_MAXIMUM=$(($HEAP_SIZE * 4 / 5))

java -Xgc:scvNoAdaptiveTenure -Xmx${HEAP_SIZE}M -Xmnx${NURSERY_MAXIMUM}M -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:concurrentScavenge -Xdisableexplicitgc -Xtune:virtualized -jar server.jar
