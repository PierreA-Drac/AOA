_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          workaround = "Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CVTSD2SS: 1 occurrences\n - CVTSS2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements. In C/C++, FP constants are double precision by default and must be suffixed by 'f' to make them single precision.",
          details = " - CVTSD2SS: 1 occurrences\n - CVTSS2SD: 2 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "8 SSE or AVX instructions are processing arithmetic or math operations on single precision FP elements in scalar mode (one at a time).\n3 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 11 FP arithmetical operations:\n - 1: addition or subtraction\n - 10: multiply\nThe binary loop is loading 4 bytes (1 single precision FP elements).\nThe binary loop is storing 16 bytes (4 single precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.55 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1551\n\nInstruction              | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n--------------------------------------------------------------------------------------------------------------------\nPXOR %XMM0,%XMM0         | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nADD $0x8,%RAX            | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCVTSS2SD (%RCX),%XMM0    | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 5       | 2\nMULSD %XMM2,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nADD %R9,%RCX             | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADDSD %XMM1,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nCVTSD2SS %XMM0,%XMM0     | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 5       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nCVTSS2SD %XMM0,%XMM0     | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 5       | 2\nMULSD %XMM3,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMOVSD %XMM0,-0x8(%RAX)   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCMP %RAX,%R10            | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE 1560 <baseline+0xa0>  | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nTEST %R8D,%R8D           | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJNE 1500 <baseline+0x40> | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nMOVSD %XMM1,(%RAX)       | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nMOVAPD %XMM1,%XMM3       | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nJMP 1504 <baseline+0x44> | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 1    | 0    | 0       | 1-2\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 25\nnb uops            : 27\nloop length        : 92\nused x86 registers : 5\nused mmx registers : 0\nused xmm registers : 4\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\nADD-SUB / MUL ratio: 0.10\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 4.50 cycles\nfront end            : 4.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7\n--------------------------------------------------------------\nuops   | 7.00 | 7.00 | 1.17 | 0.83 | 2.00 | 4.50 | 4.50 | 1.00\ncycles | 7.00 | 7.00 | 1.17 | 0.83 | 2.00 | 4.50 | 4.50 | 1.00\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 4.50\nDispatch  : 7.00\nData deps.: 1.00\nOverall L1: 7.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 50%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 50%\nFP\nall    : 5%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 25%\nINT+FP\nall    : 10%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 33%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 37%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 37%\nFP\nall    : 19%\nload   : 12%\nstore  : 25%\nmul    : 15%\nadd-sub: 25%\nother  : 25%\nINT+FP\nall    : 21%\nload   : 12%\nstore  : 25%\nmul    : 15%\nadd-sub: 25%\nother  : 29%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 7.00 cycles. At this rate:\n - 0% of peak load performance is reached (0.57 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 7% of peak store performance is reached (2.29 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
      },
      header = {
        "4% of peak computational performance is used (1.57 out of 32.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is probably not vectorized.\nOnly 21% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 7.00 to 1.12 cycles (6.22x speedup).",
        },
        {
          workaround = " - Reduce the number of FP add instructions\n - Reduce the number of FP multiply/FMA instructions\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - execution of FP add operations (the FP add unit is a bottleneck)\n - execution of FP multiply or FMA (fused multiply-add) operations (the FP multiply/FMA unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 7.00 to 4.50 cycles (1.56x speedup).\n",
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
    {
      hint = {
        {
          workaround = "Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CVTSD2SS: 1 occurrences\n - CVTSS2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements. In C/C++, FP constants are double precision by default and must be suffixed by 'f' to make them single precision.",
          details = " - CVTSD2SS: 1 occurrences\n - CVTSS2SD: 2 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "8 SSE or AVX instructions are processing arithmetic or math operations on single precision FP elements in scalar mode (one at a time).\n3 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 11 FP arithmetical operations:\n - 1: addition or subtraction\n - 10: multiply\nThe binary loop is loading 12 bytes (3 single precision FP elements).\nThe binary loop is storing 8 bytes (2 single precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.55 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1551\n\nInstruction              | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n--------------------------------------------------------------------------------------------------------------------\nMOVSD (%RAX),%XMM3       | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nPXOR %XMM0,%XMM0         | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nADD $0x8,%RAX            | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCVTSS2SD (%RCX),%XMM0    | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 5       | 2\nMULSD %XMM2,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nADD %R9,%RCX             | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADDSD %XMM1,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nCVTSD2SS %XMM0,%XMM0     | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 5       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMULSS %XMM0,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nCVTSS2SD %XMM0,%XMM0     | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 5       | 2\nMULSD %XMM3,%XMM0        | 1     | 0.50 | 0.50 | 0    | 0    | 0  | 0    | 0    | 0    | 4       | 1\nMOVSD %XMM0,-0x8(%RAX)   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCMP %RAX,%R10            | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE 1560 <baseline+0xa0>  | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nTEST %R8D,%R8D           | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJNE 1500 <baseline+0x40> | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 23\nnb uops            : 24\nloop length        : 86\nused x86 registers : 5\nused mmx registers : 0\nused xmm registers : 4\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\nADD-SUB / MUL ratio: 0.10\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 4.00 cycles\nfront end            : 4.00 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7\n--------------------------------------------------------------\nuops   | 7.00 | 7.00 | 1.00 | 1.00 | 1.00 | 3.50 | 3.50 | 1.00\ncycles | 7.00 | 7.00 | 1.00 | 1.00 | 1.00 | 3.50 | 3.50 | 1.00\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 4.00\nDispatch  : 7.00\nData deps.: 1.00\nOverall L1: 7.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 50%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 50%\nFP\nall    : 0%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 0%\nINT+FP\nall    : 5%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 20%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 37%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 37%\nFP\nall    : 17%\nload   : 18%\nstore  : 25%\nmul    : 15%\nadd-sub: 25%\nother  : 16%\nINT+FP\nall    : 19%\nload   : 18%\nstore  : 25%\nmul    : 15%\nadd-sub: 25%\nother  : 25%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 7.00 cycles. At this rate:\n - 2% of peak load performance is reached (1.71 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 3% of peak store performance is reached (1.14 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
      },
      header = {
        "4% of peak computational performance is used (1.57 out of 32.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is probably not vectorized.\nOnly 19% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 7.00 to 1.12 cycles (6.22x speedup).",
        },
        {
          workaround = " - Reduce the number of FP add instructions\n - Reduce the number of FP multiply/FMA instructions\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - execution of FP add operations (the FP add unit is a bottleneck)\n - execution of FP multiply or FMA (fused multiply-add) operations (the FP multiply/FMA unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 7.00 to 4.00 cycles (1.75x speedup).\n",
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
      "The loop is defined in /home/pierre/Bureau/AOA/kernel.c:108-121.\n",
      "The related source loop is not unrolled or unrolled with no peel/tail loop.",
      "The structure of this loop is probably <if then [else] end>.\n",
      "The presence of multiple execution paths is typically the main/first bottleneck.\nTry to simplify control inside loop: ideally, try to remove all conditional expressions, for example by (if applicable):\n - hoisting them (moving them outside the loop)\n - turning them into conditional moves, MIN or MAX\n\n",
      "Ex: if (x<0) x=0 => x = (x<0 ? 0 : x) (or MAX(0,x) after defining the corresponding macro)\n",
    },
    nb_paths = 2,
  },
}
