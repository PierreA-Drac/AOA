# C files and compiler.
CC=gcc
OBJS=driver.o kernel.o rdtsc.o
# Flags for baseline, driver, rdtsc.
ifeq ($(CC), gcc)
    CFLAGS=-O2 -g3 -Wall -lm
    ADDCLAGS=
else
    # icc wants "-lm" specified after the file names.
    CFLAGS=-O2 -g3 -Wall
    ADDCLAGS=-lm
endif
# Flags for kernel.
OPTFLAGS=-O2 -Wall
# Selection of code verison. Can be equal to "NOOPT || OPT1 || OPT2".
OPT=NOOPT

all: baseline

run: baseline
	taskset -c 2 ./baseline 89 1000 1000000

baseline: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(ADDCLAGS)

kernel.o: kernel.c
	$(CC) $(OPTFLAGS) -D $(OPT) -c $< -o $@

clean:
	rm -rf $(OBJS) baseline
