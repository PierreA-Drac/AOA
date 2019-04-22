#!/bin/bash

cpupower frequency-set -d 2.4GHz -u 2.4GHz


gcc kernel.c driver.c rdtsc.c -O2 -lm

#nombre de warmup 
for i in 10	20 50 60 100 150 200 300 400
do 
	taskset -c 1 ./a.out 220 $i 100 > tmpWa$i.csv
	#substitution de . en , pour libre office pour les graphiques
	sed -i 's/\./,/g' tmpWa$i.csv
	#trie des valeurs pour la médiane
	sort -n tmpWa$i.csv > warmup$i.csv
	#suppression du fichier temporaire
	rm tmpWa$i.csv
done
#nombre de repétision
for i in 600 700 1200 1500 1900 2100
do
	taskset -c 1 ./a.out 220 150 $i > tmpRep$i.csv
	sed -i 's/\./,/g'  tmpRep$i.csv
	sort -n tmpRep$i.csv > nbrep$i.csv
	rm tmpRep$i.csv
done

#optimisation gcc
gcc -O2 kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpGO2.csv
gcc -O3 kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpGO3.csv
gcc -O3 -march=native kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpGO3N.csv

sed -i 's/\./,/g' tmpGO2.csv tmpGO3.csv tmpGO3N.csv
sort -n tmpGO2.csv > gccO2.csv
sort -n tmpGO3.csv > gccO3.csv
sort -n tmpGO3N.csv > gccO3N.csv

rm tmpGO2.csv tmpGO3.csv tmpGO3N.csv

#optimisation icc
export PATH=$PATH:opt/intel/bin

icc -O2 kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpIO2.csv
icc -O3 kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpIO3.csv
icc -O3 -xHost kernel.c driver.c rdtsc.c -lm
./a.out 220 150 2000 > tmpIO3H.csv

sed -i 's/\./,/g' tmpIO2.csv tmpIO3.csv tmpIO3H.csv
sort -n tmpIO2.csv > iccO2.csv
sort -n tmpIO3.csv > iccO3.csv
sort -n tmpIO3H.csv > iccO3H.csv

rm tmpIO2.csv tmpIO3.csv tmpIO3H.csv

