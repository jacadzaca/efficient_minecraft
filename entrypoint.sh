#!/bin/sh
java -Xgc:scvNoAdaptiveTenure -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:concurrentScavenge -Xdisableexplicitgc -Xtune:virtualized -jar minecraft_server.1.12.jar