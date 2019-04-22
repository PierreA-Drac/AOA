_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          workaround = "Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CVTSD2SS: 2 occurrences\n - CVTSS2SD: 2 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements. In C/C++, FP constants are double precision by default and must be suffixed by 'f' to make them single precision.",
          details = " - CVTSD2SS: 2 occurrences\n - CVTSS2SD: 4 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "16 SSE or AVX instructions are processing arithmetic or math operations on single precision FP elements in scalar mode (one at a time).\n6 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 22 FP arithmetical operations:\n - 2: addition or subtraction\n - 20: multiply\nThe binary loop is loading 8 bytes (2 single precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 2.75 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1560\n\nInstruction                  | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7 | Latency | Recip. throughput\n----------------------------------------------------------------------------------------------------------------------\nPXOR %XMM1,%XMM1             | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0  | 0       | 0.25\nLEA 0x1(%RAX),%ECX           | 1     | 0    | 0.50 | 0    | 0    | 0  | 0.50 | 0    | 0  | 1       | 0.50\nCVTSS2SD (%RSI,%RAX,4),%XMM1 | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0  | 5       | 2\nMULSD %XMM2,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nADD $0x2,%RAX                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0  | 1       | 0.25\nMOVAPD %XMM1,%XMM0           | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0  | 0       | 0.25\nPXOR %XMM1,%XMM1             | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0  | 0       | 0.25\nADDSD %XMM3,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCVTSS2SD (%RSI,%RCX,4),%XMM1 | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0  | 5       | 2\nMULSD %XMM2,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCVTSD2SS %XMM0,%XMM0         | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0  | 5       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nADDSD %XMM3,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCVTSD2SS %XMM1,%XMM1         | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0  | 5       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM0,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCVTSS2SD %XMM0,%XMM0         | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0  | 5       | 2\nMULSD %XMM4,%XMM0            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nPXOR %XMM4,%XMM4             | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0  | 0       | 0.25\nMULSS %XMM1,%XMM1            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCVTSS2SD %XMM1,%XMM4         | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0  | 5       | 2\nMULSD %XMM0,%XMM4            | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0  | 4       | 1\nCMP %EAX,%R8D                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0  | 1       | 0.25\nJA 1560 <baseline+0xa0>      | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0  | 0       | 0.50-1\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 36\nnb uops            : 39\nloop length        : 146\nused x86 registers : 4\nused mmx registers : 0\nused xmm registers : 5\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\nADD-SUB / MUL ratio: 0.10\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 6.50 cycles\nfront end            : 6.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0    | P1    | P2   | P3   | P4   | P5   | P6   | P7\n----------------------------------------------------------------\nuops   | 14.50 | 14.50 | 1.00 | 1.00 | 0.00 | 4.00 | 2.00 | 0.00\ncycles | 14.50 | 14.50 | 1.00 | 1.00 | 0.00 | 4.00 | 2.00 | 0.00\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 8.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 6.50\nDispatch  : 14.50\nData deps.: 8.00\nOverall L1: 14.50\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 100%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 100%\nFP\nall    : 3%\nload   : 0%\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : 0%\nadd-sub: 0%\nother  : 14%\nINT+FP\nall    : 12%\nload   : 0%\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : 0%\nadd-sub: 0%\nother  : 40%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 50%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 50%\nFP\nall    : 17%\nload   : 12%\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : 15%\nadd-sub: 25%\nother  : 21%\nINT+FP\nall    : 20%\nload   : 12%\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : 15%\nadd-sub: 25%\nother  : 30%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 14.50 cycles. At this rate:\n - 0% of peak load performance is reached (0.55 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
      },
      header = {
        "4% of peak computational performance is used (1.52 out of 32.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is probably not vectorized.\nOnly 20% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 14.50 to 2.31 cycles (6.27x speedup).",
        },
        {
          workaround = " - Reduce the number of FP add instructions\n - Reduce the number of FP multiply/FMA instructions\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - execution of FP add operations (the FP add unit is a bottleneck)\n - execution of FP multiply or FMA (fused multiply-add) operations (the FP multiply/FMA unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 14.50 to 6.50 cycles (2.23x speedup).\n",
        },
      },
      potential = {
        {
          workaround = " - Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64\n - Try to change order in which elements are evaluated (using parentheses) in arithmetic expressions containing both ADD/SUB and MUL operations to enable your compiler to generate FMA instructions wherever possible.\nFor instance a + b*c is a valid FMA (MUL then ADD).\nHowever (a+b)* c cannot be translated into an FMA (ADD then MUL).\n",
          title = "FMA",
          txt = "Presence of both ADD/SUB and MUL operations.",
        },
      },
    },
  },
  common = {
    header = {
      "The loop is defined in /home/pierre/Bureau/AOA/kernel.c:151-166.\n",
      "The related source loop is not unrolled or unrolled with no peel/tail loop.",
    },
    nb_paths = 1,
  },
}
