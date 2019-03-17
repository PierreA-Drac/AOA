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
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 224 bytes.\nThe binary loop is storing 264 bytes.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 2129\n\nInstruction                                 | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n---------------------------------------------------------------------------------------------------------------------------------------\nVMOVSS (%R14,%RBX,2),%XMM14                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R15,%RBX,2),%XMM1                  | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R15),%XMM3                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R14),%XMM0                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVINSERTPS $0x10,(%R14,%R12,1),%XMM14,%XMM15 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R14,%RBX,1),%XMM0,%XMM2   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R15,%R12,1),%XMM1,%XMM4   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R15,%RBX,1),%XMM3,%XMM5   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVMOVLHPS %XMM15,%XMM2,%XMM7                 | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVMOVLHPS %XMM4,%XMM5,%XMM6                  | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVINSERTF128 $0x1,%XMM7,%YMM6,%YMM8          | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM8,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nVMOVAPS %YMM8,-0xb0(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nVMOVAPS -0xb0(%RBP),%YMM9                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMOVAPD %YMM0,-0x90(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVEXTRACTF128 $0x1,%YMM9,%XMM10              | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM10,%YMM0                      | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nMOV -0x38(%RBP),%RDX                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nVMOVUPD %YMM0,0x20(%R13)                    | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nADD %RDX,%R15                               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD %RDX,%R14                               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nVMOVSS (%R14,%RBX,2),%XMM12                 | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R14),%XMM14                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R15),%XMM1                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVMOVSS (%R15,%RBX,2),%XMM0                  | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 0       | 0.50\nVINSERTPS $0x10,(%R14,%R12,1),%XMM12,%XMM13 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R15,%R12,1),%XMM0,%XMM2   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R14,%RBX,1),%XMM14,%XMM15 | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVINSERTPS $0x10,(%R15,%RBX,1),%XMM1,%XMM4   | 2     | 0    | 0    | 0.50 | 0.50 | 0  | 1    | 0    | 0    | 4       | 1\nVMOVAPD -0x90(%RBP),%YMM11                  | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMOVLHPS %XMM2,%XMM4,%XMM3                  | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nVMOVLHPS %XMM13,%XMM15,%XMM5                | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 1       | 1\nLEA 0x40(%R13),%RDI                         | 1     | 0    | 0.50 | 0    | 0    | 0  | 0.50 | 0    | 0    | 1       | 0.50\nVINSERTF128 $0x1,%XMM5,%YMM3,%YMM6          | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVMOVUPD %YMM11,(%R13)                       | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nMOV %RDI,-0x60(%RBP)                        | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVCVTPS2PD %XMM6,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nVMOVAPS %YMM6,-0xb0(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nVMOVAPS -0xb0(%RBP),%YMM7                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nVMOVAPD %YMM0,-0x90(%RBP)                   | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nVEXTRACTF128 $0x1,%YMM7,%XMM8               | 1     | 0    | 0    | 0    | 0    | 0  | 1    | 0    | 0    | 3       | 1\nVCVTPS2PD %XMM8,%YMM0                       | 2     | 0.50 | 0.50 | 0    | 0    | 0  | 1    | 0    | 0    | 7       | 1\nCALL 24b0 <_ZGVdN4v___exp_finite>           | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nVMOVAPD -0x90(%RBP),%YMM9                   | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nMOV -0x38(%RBP),%R8                         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nMOV -0x60(%RBP),%RSI                        | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nVMOVUPD %YMM9,0x40(%R13)                    | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nSUB $-0x80,%R13                             | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nVMOVUPD %YMM0,0x20(%RSI)                    | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nADD %R8,%R15                                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD %R8,%R14                                | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCMP -0x48(%RBP),%R13                        | 1     | 0.25 | 0.25 | 0.50 | 0.50 | 0  | 0.25 | 0.25 | 0    | 1       | 0.50\nJNE 2129 <baseline+0x5b9>                   | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 56\nnb uops            : 71\nloop length        : 314\nused x86 registers : 10\nused mmx registers : 0\nused xmm registers : 14\nused ymm registers : 7\nused zmm registers : 0\nnb stack references: 5\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 11.83 cycles\nfront end            : 11.83 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2    | P3    | P4    | P5    | P6   | P7\n-------------------------------------------------------------------\nuops   | 5.00 | 5.00 | 12.33 | 12.33 | 13.00 | 20.00 | 5.00 | 12.33\ncycles | 5.00 | 5.00 | 12.33 | 12.33 | 13.00 | 20.00 | 5.00 | 12.33\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 2.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 11.83\nDispatch  : 20.00\nData deps.: 2.00\nOverall L1: 20.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : 0%\nstore  : 0%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall    : 60%\nload   : 20%\nstore  : 100%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 60%\nINT+FP\nall    : 55%\nload   : 18%\nstore  : 88%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 60%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 25%\nload   : 25%\nstore  : 25%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall    : 47%\nload   : 30%\nstore  : 100%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 30%\nINT+FP\nall    : 45%\nload   : 29%\nstore  : 91%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 30%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 20.00 cycles. At this rate:\n - 17% of peak load performance is reached (11.20 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 41% of peak store performance is reached (13.20 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "0% of peak computational performance is used (0.00 out of 4.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "55% of SSE/AVX instructions are used in vector version (process two or more data elements in vector registers):\n - 18% of SSE/AVX loads are used in vector version.\n - 88% of SSE/AVX stores are used in vector version.\n - 60% of SSE/AVX instructions that are not load, store, addition, subtraction nor multiply instructions are used in vector version.\nSince your execution units are vector units, only a fully vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is partially vectorized.\nOnly 45% of vector register length is used (average across all SSE/AVX instructions).\nBy fully vectorizing your loop, you can lower the cost of an iteration from 20.00 to 12.25 cycles (1.63x speedup).",
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
