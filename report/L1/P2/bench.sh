#!/bin/bash

# Global variables
# ==============================================================================

# Exit on error.
set -e

# Size of matrix ((n^2 * 4) + (n * 8) Bytes). Fit in L1 cache memory.
n=88
# Number of repetition for first warm-up.
wrep=1000
# Number of repetition of kernel function for one meta-repetition (about 3s of execution time).
# krep=100000
krep=10000
# Number of meta-repetition (according to source code, it's a constant).
mrep=31

# Result directory.
res_dir='./report/L1/P2'
# Temporary file used to store results.
tmp='/tmp/bench'

# Compilation configuration.
cc='gcc'
cflags='-O2'

# List of optimisations versions to test.
opts=( 'NOOPT' 'L1_OPT1' 'L1_OPT2' )

# Functions
# ==============================================================================

# Clean the directory and compile according to specified version and options.
function compil
{
    make clean
    CFLAGS="$4" make OPT=$1 CC=$2 OPTFLAGS="$3"
}

# Launch the kernel, display results to stdout and store them in a file.
function bench
{
    taskset -c 1 ./baseline $n $wrep $krep | tee $1
}

# Take the median number of the file and display it to stdout.
function res
{
    cat $1 | sort | cut -d' ' -f1 | sed "$(($mrep/2))"'!d'
}

# Launch a new benchmark with a predifined command line.
function bench_cmd
{
    echo "================================================================================"
    echo -e "\033[1;33mBenchmark \033[1;31m'$1'\033[1;33m with $4 and \033[1;31m'$2 $3'\033[1;33m :\033[0;37m"
    # Compil according to the given configuration.
    compil $1 $2 "$3"
    echo -e -n "\033[m"
    # Launch the benchmark.
    time=`date '+%s'`
    eval "$5"
    echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"
    # Store result.
    eval "$6"
}

# Initialization
# ==============================================================================
 
# Execute only from directory with .git folder in it.
echo -n "Checking that this script is executing from the project root directory... "
ls -alh | grep .git > /dev/null
echo OK !

# Set the CPU mode into performance and fix the frequency.
sudo cpupower frequency-set -g performance

# Load the MSR kernel module and allow access to hardware counters.
sudo modprobe msr
sudo sh -c 'echo -1 > /proc/sys/kernel/perf_event_paranoid'

# Print benchmark informations.
echo -e "========================= \033[1;34mBenchmarks informations\033[m =============================="
echo -e "\033[33mSize of matrix :\033[m ($n^2 * 4) + ($n * 8) Bytes"
echo -e "\033[33mNumber of repetition for the warm-up :\033[m $wrep times"
echo -e "\033[33mNumber of repetition for kernel :\033[m $krep times"
echo -e "\033[33mNumber of meta-repetition of program :\033[m $mrep times"

# Benchmark with RDTSC
# ==============================================================================

# Result file.
res="$res_dir/rdtsc.txt"

# Reset res file.
echo -n "" > $res

# Main loop which test all optimisations versions.
for (( i = 0; i < ${#opts[*]}; i++ )); do
    bench_cmd ${opts[$i]} $cc "$cflags" "RDTSC" 'bench $tmp' 'echo -n "$1,$2,$3," >> $res && res $tmp >> $res'
done

# Benchmark with MAQAO
# ==============================================================================

for (( i = 0; i < ${#opts[*]}; i++ )); do
    bench_cmd ${opts[$i]} $cc "$cflags -g" "MAQAO" 'rm -rf "$res_dir/maqao_$1" && maqao oneview -xp="$res_dir/maqao_$1" --create-report=one --binary=baseline --run-command="<binary> $n $wrep $krep"'
done

# Benchmark with LIKWID
# ==============================================================================

for (( i = 0; i < ${#opts[*]}; i++ )); do
    bench_cmd ${opts[$i]} $cc "$cflags" "LIKWID" 'sudo likwid-perfctr -f -M 0 -C 1 -g L2 -g L2CACHE ./baseline $n $wrep $krep | tee "$res_dir/likwid_$1.txt"'
done
