## Binary section ..............................................................:

# C files and compiler.
CC=gcc
OBJS=driver.o kernel.o rdtsc.o
# Flags for baseline, driver, rdtsc.
CFLAGS+=-O2 -g -Wall
LFLAGS=-lm
# Flags for kernel.
OPTFLAGS=-O2 -Wall
# Selection of code version. Can be equal to "NOOPT || OPT_IF_HOISTING ...".
OPT=NOOPT

all: baseline

run: baseline
	./baseline 88 1000 1000000

baseline: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LFLAGS)

kernel.o: kernel.c
	$(CC) $(OPTFLAGS) -D $(OPT) -c $< -o $@
	
## Report section ..............................................................:

# LaTeX compiler.
LATEX = pdflatex

# LaTeX compiler parameters.
LATEX_ARGS = --shell-escape

# Report directory name.
REPORT_DIR = ./report

# Report file name.
REPORT_NAME = report.tex

# Report full path (without extension).
REPORT = $(REPORT_DIR)/report

# Generating the report (2-times to generate the Table Of Contents).
$(REPORT).pdf: $(REPORT).tex
	cd $(REPORT_DIR) && $(LATEX) $(LATEX_ARGS) $(REPORT_NAME)
	cd $(REPORT_DIR) && $(LATEX) $(LATEX_ARGS) $(REPORT_NAME)
report: $(REPORT).pdf

## General section .............................................................:

clean:
	rm -rf $(OBJS) baseline
	
mrproper: clean
	rm -rf $(REPORT).aux $(REPORT).log $(REPORT).out $(REPORT).toc         \
	       $(REPORT_DIR)/svg-inkscape $(REPORT_DIR)/_minted-report         \
	       ./db_implem/Logs/*.log
