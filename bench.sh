#!/bin/bash

# Exit on error.
set -e

# Size of matrix ((n^2 * 4) + (n * 8) Bytes). Fit in L1 cache memory.
n=89
# Number of repetition for first warm-up.
wrep=1000
# Number of repetition of kernel function for one meta-repetition (about 3s of execution time).
krep=1000000
# Number of meta-repetition (according to source code, it's a constant).
mrep=31

# Temporary file used to store results.
tmp='/tmp/bench'
# Result file.
res='./report/L1/bench.txt'

# Set of benchmarks to do.
cc=(
    'gcc' 'gcc' 'gcc' 'gcc' 'gcc'
    'icc' 'icc' 'icc' 'icc' 'icc'
)
cflags=(
    '-O0' '-O2' '-O3' '-Os' '-O3 -march=native'
    '-O0' '-O2' '-O3' '-Os' '-O3 -xHost'
)

# Take the median number of the ifile and display it to stdout.
function res
{
    cat $1 | sort | cut -d' ' -f1 | sed "$(($mrep/2))"'!d'
}

# Clean the directory and compile according to specified options.
function compil
{
    make clean
    make CC=$1 OPTFLAGS="$2"
}


# Launch a benchmark, display results to stdout and store them in ofile.
function bench
{
    taskset -c 1 ./baseline $n $wrep $krep | tee $1
}

# Set the CPU mode into performance (for laptop).
sudo cpupower frequency-set -g performance
echo "================================================================================"

# Reset res file.
echo -n "" > $res

# Main loop which test all benchmarks configurations.
for (( i = 0; i < ${#cc[*]}; i++ )); do
    # Get compiler and optimisations flags.
    cci=${cc[$i]}
    cflagsi="${cflags[$i]}"
    # Launch the benchmark.
    echo -e "\033[1;31mBenchmark with \033[1;34m'$cci $cflagsi'\033[1;31m :\033[0;37m"
    compil $cci "$cflagsi"
    echo -e -n "\033[m"
    bench $tmp
    echo "================================================================================"
    # Write the results into the final file.
    echo -n "$cci $cflagsi;" >> $res
    res $tmp >> $res
done

# Set the CPU mode into powersave (for laptop).
sudo cpupower frequency-set -g powersave
