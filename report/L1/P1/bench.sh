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
krep=100000
# Number of meta-repetition (according to source code, it's a constant).
mrep=31

# Result directory.
res_dir='./report/L1/P1'
# Temporary file used to store results.
tmp='/tmp/bench'
# Result file.
res="$res_dir/compil.txt"

# Global functions
# ==============================================================================

# Clean the directory and compile according to specified options.
function compil
{
    make clean
    CFLAGS="$3" make CC=$1 OPTFLAGS="$2"
}

# Launch a benchmark, display results to stdout and store them in ofile.
function bench
{
    taskset -c 1 ./baseline $n $wrep $krep | tee $1
}

# Take the median number of the ifile and display it to stdout.
function res
{
    cat $1 | sort | cut -d' ' -f1 | sed "$(($mrep/2))"'!d'
}

# Initialization
# ==============================================================================
 
# Execute only from directory with .git folder in it.
echo -n "Checking that this script is executing from the project root directory... "
ls -alh | grep .git > /dev/null
echo OK !

# Set the CPU mode into performance (for laptop) and print benchmark informations.
sudo cpupower frequency-set -g performance
echo -e "========================= \033[1;34mBenchmarks informations\033[m =============================="
echo -e "\033[33mSize of matrix :\033[m ($n^2 * 4) + ($n * 8) Bytes"
echo -e "\033[33mNumber of repetition for the warm-up :\033[m $wrep times"
echo -e "\033[33mNumber of repetition for kernel :\033[m $krep times"
echo -e "\033[33mNumber of meta-repetition of program :\033[m $mrep times"
echo "================================================================================"

# Reset res file.
echo -n "" > $res

# Benchmark differents flags
# ==============================================================================

# Set of benchmarks to do.
cc=(
    'gcc' 'gcc' 'gcc' 'gcc' 'gcc' 'gcc' 'gcc' 'gcc'
    'clang' 'clang' 'clang' 'clang' 'clang' 'clang' 'clang'
    'icc' 'icc' 'icc' 'icc' 'icc' 'icc' 'icc' 'icc'
)
cflags=(
    '-O0' '-O2' '-O3' '-Os' '-O3 -march=native' '-Ofast' '-Ofast -march=native' '-Ofast -march=native -funroll-all-loops'
    '-O0' '-O2' '-O3' '-Os' '-O3 -march=native' '-Ofast' '-Ofast -march=native'
    '-O0' '-O2' '-O3' '-Os' '-O3 -xHost' '-Ofast' '-Ofast -xHost' '-Ofast -xHost -funroll-loops -unroll-aggressive'
)

# Main loop which test all benchmarks configurations.
for (( i = 0; i < ${#cc[*]}; i++ )); do
    time=`date '+%s'`
    # Get compiler and optimisations flags.
    cci=${cc[$i]}
    cflagsi="${cflags[$i]}"
    # Launch the benchmark.
    echo -e "\033[1;33mBenchmark with \033[1;31m'$cci $cflagsi'\033[1;33m :\033[0;37m"
    compil $cci "$cflagsi"
    echo -e -n "\033[m"
    bench $tmp
    echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"
    echo "================================================================================"
    # Write the results into the final file.
    echo -n "$cci,$cflagsi," >> $res
    res $tmp >> $res
done

# Compiler and flags for reference benchmark.
cc_ref="gcc"
cflags_ref="-O2 -g"
# Compiler and flags for optimal compilation (most speed-up).
cc_opt=`cat $res | sed -e 's/\(.*\),\(.*\),\(.*\)/\3,\1,\2/' | sort -g | cut -d',' -f2 | sed -e '2,$ d'`
cflags_opt=`cat $res | sed -e 's/\(.*\),\(.*\),\(.*\)/\3,\1,\2/' | sort -g | cut -d',' -f3 | sed -e '2,$ d'`
# Load the MSR kernel module.
sudo modprobe msr

# Benchmark with MAQAO
# ==============================================================================

# Reference benchmark.
echo "================================================================================"
time=`date '+%s'`
echo -e "\033[1;33mBenchmark with MAQAO and \033[1;31m'$cc_ref $cflags_ref'\033[1;33m :\033[0;37m"
compil $cc_ref "$cflags_ref"
echo -e -n "\033[m"
rm -rf maqao_ref && maqao oneview -xp="$res_dir/maqao_ref" --create-report=one --binary=baseline --run-command="<binary> $n $wrep $krep"
echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"

# Greatest speed-up benchmark.
echo "================================================================================"
time=`date '+%s'`
echo -e "\033[1;33mBenchmark with MAQAO and \033[1;31m'$cc_opt $cflags_opt'\033[1;33m :\033[0;37m"
compil $cc_opt "$cflags_opt" "-funroll-loops"
echo -e -n "\033[m"
rm -rf maqao_opt && maqao oneview -xp="$res_dir/maqao_opt" --create-report=one --binary=baseline --run-command="<binary> $n $wrep $krep" --force-all-loops
echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"
echo "================================================================================"

# Benchmark with LIKWID
# ==============================================================================

# Reference benchmark.
echo "================================================================================"
time=`date '+%s'`
echo -e "\033[1;33mBenchmark with LIKWID and \033[1;31m'$cc_ref $cflags_ref'\033[1;33m :\033[0;37m"
compil $cc_ref "$cflags_ref"
echo -e -n "\033[m"
sudo likwid-perfctr -M 0 -C 1 -g L2 -g L2CACHE ./baseline $n $wrep $krep | tee "$res_dir/likwid_ref.txt"
echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"

# Greatest speed-up benchmark.
echo "================================================================================"
time=`date '+%s'`
echo -e "\033[1;33mBenchmark with LIKWID and \033[1;31m'$cc_opt $cflags_opt'\033[1;33m :\033[0;37m"
compil $cc_opt "$cflags_opt" "-funroll-loops"
echo -e -n "\033[m"
sudo likwid-perfctr -M 0 -C 1 -g L2 -g L2CACHE ./baseline $n $wrep $krep | tee "$res_dir/likwid_opt.txt"
echo -e "\033[1;33mTime elapsed : \033[1;31m'$((`date '+%s'` - $time))'\033[1;33m seconds\033[0;37m"
echo "================================================================================"

# Ending
# ==============================================================================

# Set the CPU mode into powersave (for laptop).
sudo cpupower frequency-set -g powersave
make clean
