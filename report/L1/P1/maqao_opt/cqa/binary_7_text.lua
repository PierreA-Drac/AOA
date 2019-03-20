_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CALL: 4 occurrences\n - VCVTPS2PD: 4 occurrences\n - VINSERTPS: 8 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = " - Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64\n - Use vector aligned instructions:\n  1) align your arrays on 32 bytes boundaries: replace { void *p = malloc (size); } with { void *p; posix_memalign (&p, 32, size); }.\n  2) inform your compiler that your arrays are vector aligned: if array 'foo' is 32 bytes-aligned, define a pointer 'p_foo' as __builtin_assume_aligned (foo, 32) and use it instead of 'foo' in the loop.\n",
          details = " - VEXTRACTF128: 2 occurrences\n - VINSERTF128: 2 occurrences\n",
          title = "Vector unaligned load/store instructions",
          txt = "Detected 4 suboptimal vector unaligned load/store instructions.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements. In C/C++, FP constants are double precision by default and must be suffixed by 'f' to make them single precision.",
          details = " - VCVTPS2PD: 4 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "4 AVX instructions are processing arithmetic or math operations on double precision FP elements in vector mode (four at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 16 FP arithmetical operations:\n - 16: multiply\nThe binary loop is loading 352 bytes (44 double precision FP elements).\nThe binary loop is storing 264 bytes (33 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.03 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1d13\n\nInstruction                                 | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n---------------------------------------------------------------------------------------------------------------------------------------\nVMOVSS (%RBX,%R13,2),%XMM10                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%RBX),%XMM12                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R12,%R13,2),%XMM14                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R12),%XMM0                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVINSERTPS $0x10,(%RBX,%R15,1),%XMM10,%XMM11 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%RBX,%R13,1),%XMM12,%XMM13 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R12,%R15,1),%XMM14,%XMM15 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R12,%R13,1),%XMM0,%XMM2   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVMOVLHPS %XMM11,%XMM13,%XMM4                | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVMOVLHPS %XMM15,%XMM2,%XMM1                 | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVINSERTF128 $0x1,%XMM4,%YMM1,%YMM3          | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM3,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nVMOVAPS %YMM3,-0xb0(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nVMOVAPS -0xb0(%RBP),%YMM5                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMOVAPD %YMM0,-0x90(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVEXTRACTF128 $0x1,%YMM5,%XMM6               | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM6,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nMOV -0x38(%RBP),%R9                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nVMOVAPD -0x90(%RBP),%YMM8                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nADD %R9,%R12                                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD %R9,%RBX                                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nVMULPD 0x20(%R14),%YMM0,%YMM7               | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 4       | 0.50\nVMULPD (%R14),%YMM8,%YMM9                   | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 4       | 0.50\nVMOVSS (%RBX,%R13,2),%XMM10                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%RBX),%XMM12                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R12,%R13,2),%XMM14                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R12),%XMM0                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVINSERTPS $0x10,(%RBX,%R15,1),%XMM10,%XMM11 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R12,%R13,1),%XMM0,%XMM2   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%RBX,%R13,1),%XMM12,%XMM13 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R12,%R15,1),%XMM14,%XMM15 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVMOVLHPS %XMM11,%XMM13,%XMM4                | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVMOVLHPS %XMM15,%XMM2,%XMM1                 | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVMOVUPD %YMM9,(%R14)                        | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVMOVUPD %YMM7,0x20(%R14)                    | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nLEA 0x40(%R14),%R8                          | 1     | 0    | 0.50 | 0    | 0    | 0  | 0.50 | 0    | 0    | 1       | 0.50\nVINSERTF128 $0x1,%XMM4,%YMM1,%YMM3          | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nMOV %R8,-0x60(%RBP)                         | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVCVTPS2PD %XMM3,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nVMOVAPS %YMM3,-0xb0(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nVMOVAPS -0xb0(%RBP),%YMM5                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMOVAPD %YMM0,-0x90(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVEXTRACTF128 $0x1,%YMM5,%XMM6               | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM6,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nMOV -0x60(%RBP),%R11                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nVMOVAPD -0x90(%RBP),%YMM8                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMULPD 0x20(%R11),%YMM0,%YMM7               | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 4       | 0.50\nVMULPD 0x40(%R14),%YMM8,%YMM9               | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 4       | 0.50\nSUB $-0x80,%R14                             | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nVMOVUPD %YMM9,-0x40(%R14)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVMOVUPD %YMM7,0x20(%R11)                    | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nMOV -0x38(%RBP),%R10                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nADD %R10,%R12                               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD %R10,%RBX                               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCMP -0x48(%RBP),%R14                        | 1     | 0.25 | 0.25 | 0.50 | 0.50 | 0  | 0.25 | 0.25 | 0    | 1       | 0.50\nJNE 1d13 <baseline+0x1a3>                   | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 60\nnb uops            : 75\nloop length        : 336\nused x86 registers : 10\nused mmx registers : 0\nused xmm registers : 12\nused ymm registers : 7\nused zmm registers : 0\nnb stack references: 5\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 12.50 cycles\nfront end            : 12.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2    | P3    | P4    | P5    | P6   | P7\n-------------------------------------------------------------------\nuops   | 6.50 | 6.25 | 14.00 | 14.00 | 13.00 | 20.00 | 6.25 | 13.00\ncycles | 6.50 | 6.25 | 14.00 | 14.00 | 13.00 | 20.00 | 6.25 | 13.00\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 2.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 12.50\nDispatch  : 20.00\nData deps.: 2.00\nOverall L1: 20.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : 0%\nstore  : 0%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall    : 63%\nload   : 33%\nstore  : 100%\nmul    : 100%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 60%\nINT+FP\nall    : 59%\nload   : 30%\nstore  : 88%\nmul    : 100%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 60%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 25%\nload   : 25%\nstore  : 25%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall    : 52%\nload   : 41%\nstore  : 100%\nmul    : 100%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 30%\nINT+FP\nall    : 50%\nload   : 40%\nstore  : 91%\nmul    : 100%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 30%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 20.00 cycles. At this rate:\n - 27% of peak load performance is reached (17.60 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 41% of peak store performance is reached (13.20 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "5% of peak computational performance is used (0.80 out of 16.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "59% of SSE/AVX instructions are used in vector version (process two or more data elements in vector registers):\n - 30% of SSE/AVX loads are used in vector version.\n - 88% of SSE/AVX stores are used in vector version.\n - 60% of SSE/AVX instructions that are not load, store, addition, subtraction nor multiply instructions are used in vector version.\nSince your execution units are vector units, only a fully vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is partially vectorized.\nOnly 50% of vector register length is used (average across all SSE/AVX instructions).\nBy fully vectorizing your loop, you can lower the cost of an iteration from 20.00 to 12.25 cycles (1.63x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
      },
    },
  },
  common = {
    header = {
      "",
    },
    nb_paths = 1,
  },
}
