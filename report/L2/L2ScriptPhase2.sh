#!/bin/bash
cpupower frequency-set -d 2.4GHz -u 2.4GHz

sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'

for i in 1 2 3 4 5 6
do 
   rm -r maqaoT$i
done

gcc -O2 driver.c kernel.c rdtsc.c  -lm
taskset -c 1 ./a.out  120 150 1200 > tmptest1.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT1

gcc -O3 driver.c kernel.c rdtsc.c -g -lm
taskset -c 1 ./a.out 120 150 1200 > tmptest2.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT2

gcc -O3 -funroll-loops driver.c kernel.c rdtsc.c -g -lm
taskset -c 1 ./a.out 120 150 1200 > tmptest3.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT3

gcc -O3 -funroll-loops driver.c kernel.c rdtsc.c -g -lm
taskset -c 1 ./a.out 120 150 1200 > tmptest4.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT4


gcc -O3 -funroll-loops driver.c kernel.c rdtsc.c -g -lm
taskset -c 1 ./a.out 120 150 1200 > tmptest5.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT5


gcc -O3 -funroll-loops driver.c kernel.c rdtsc.c -g -lm
	taskset -c 1 ./a.out 120 150 1200 > tmptest6.csv
maqao oneview -xp=maqao --create-report=one --binary=a.out --run-command="<binary> 120 150 1200"
mv maqao maqaoT6



for i in 1 2 3 4 5 6
do	
	sed -i 's/\./,/g' tmptest$i.csv
	#trie des valeurs pour la médiane
	sort -n tmptest$i.csv > test$i.csv
	#suppression du fichier temporaire
	rm tmptest$i.csv 
done
