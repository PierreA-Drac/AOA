# C files and compiler.
CC=gcc
OBJS=driver.o kernel.o rdtsc.o
# Flags for baseline, driver, rdtsc.
CFLAGS=-O2 -g3 -Wall
LFLAGS=-lm
# Flags for kernel.
OPTFLAGS=-O2 -Wall
# Selection of code verison. Can be equal to "NOOPT || OPT1 || OPT2".
OPT=NOOPT

all: baseline

run: baseline
	./baseline 88 1000 1000000

baseline: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LFLAGS)

kernel.o: kernel.c
	$(CC) $(OPTFLAGS) -D $(OPT) -c $< -o $@

clean:
	rm -rf $(OBJS) baseline
