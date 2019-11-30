#!/bin/sh
HEAP_SIZE=2096

NURSERY_MINIMUM=$(($HEAP_SIZE / 2))
NURSERY_MAXIMUM=$(($HEAP_SIZE * 4 / 5))

java -Xgc:scvNoAdaptiveTenure -Xms${HEAP_SIZE}M -Xmx${HEAP_SIZE}M -Xmns${NURSERY_MINIMUM}M -Xmnx${NURSERY_MAXIMUM}M -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:concurrentScavenge -Xdisableexplicitgc -Xtune:virtualized -jar minecraft_server.1.12.jar
