CC=gcc
CFLAGS=-O2 -g -Wall -lm
OPTFLAGS=-O3 -g -Wall
OBJS=driver.o kernel.o rdtsc.o
# Can be equal to NOOPT || OPT1 || OPT2
OPT=NOOPT

all: baseline

run: baseline
	./baseline 300 100 30

baseline: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

kernel.o: kernel.c
	$(CC) $(OPTFLAGS) -D $(OPT) -c $< -o $@

clean:
	rm -rf $(OBJS) baseline
