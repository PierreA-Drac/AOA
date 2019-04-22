_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This function is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your function (in the source code) and the binary function",
          txt = "The binary function does not contain any FP arithmetical operations.\nThe binary function does not load or store any data.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the function is: bc0\n\nInstruction            | Nb FU | P0   | P1   | P2 | P3 | P4 | P5   | P6   | P7 | Latency | Recip. throughput\n------------------------------------------------------------------------------------------------------------\nTEST %EDI,%EDI         | 1     | 0.25 | 0.25 | 0  | 0  | 0  | 0.25 | 0.25 | 0  | 1       | 0.25\nJE c5c <baseline+0x9c> | 1     | 0.50 | 0    | 0  | 0  | 0  | 0    | 0.50 | 0  | 0       | 0.50-1\nRET\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 3\nnb uops            : 2\nloop length        : 10\nused x86 registers : 1\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 0.50 cycles\nfront end            : 0.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7\n--------------------------------------------------------------\nuops   | 0.50 | 0.50 | 0.00 | 0.00 | 0.00 | 0.50 | 0.50 | 0.00\ncycles | 0.50 | 0.50 | 0.00 | 0.00 | 0.00 | 0.50 | 0.50 | 0.00\n\nCycles executing div or sqrt instructions: NA\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 0.50\nDispatch  : 0.50\nOverall L1: 0.50\n",
        },
        {
          title = "Vectorization ratios",
          txt = "No vectorizable/vectorized instructions\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "No vectorizable/vectorized instructions\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each call to the function takes 0.50 cycles. At this rate:\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n",
        },
      },
      header = {
        "Warnings:\nThe number of fused uops of the instruction [RET] is unknown",
        "0% of peak computational performance is used (0.00 out of 4.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          details = "No SSE/AVX instruction: only general purpose registers are used and data elements are processed one at a time.\n",
          title = "Vectorization",
          txt = "Your function is not vectorized.\n",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
      },
    },
    {
      hint = {
        {
          workaround = "Pass to your compiler a micro-architecture specialization option:\n - Please read your compiler manual\n",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CALL: 1 occurrences\n - CVTSS2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - CVTSS2SD: 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "1 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your function (in the source code) and the binary function",
          txt = "The binary function is composed of 1 FP arithmetical operations:\n - 1: multiply\nThe binary function is loading 24 bytes (3 double precision FP elements).\nThe binary function is storing 20 bytes (2 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.02 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the function is: bc0\n\nInstruction                 | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n-----------------------------------------------------------------------------------------------------------------------\nTEST %EDI,%EDI              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE c5c <baseline+0x9c>      | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nPUSH %R15\nLEA -0x1(%RDI),%EAX         | 1     | 0    | 0.50 | 0    | 0    | 0  | 0.50 | 0    | 0    | 1       | 0.50\nPUSH %R14\nPUSH %R13\nPUSH %R12\nMOV %RSI,%R13               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nPUSH %RBP\nPUSH %RBX\nMOV %EDI,%EBP               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nLEA 0x8(%RDX,%RAX,8),%R12   | 1     | 0    | 1    | 0    | 0    | 0  | 0    | 0    | 0    | 3       | 1\nSAL $0x2,%RBP               | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 1       | 0.50\nXOR %EBX,%EBX               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nSUB $0x18,%RSP              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nMOV %RDX,0x8(%RSP)          | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nMOV %EDI,0x4(%RSP)          | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nNOPW (%RAX,%RAX,1)          | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nMOV 0x8(%RSP),%R15          | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nMOV %R13,%R14               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nTEST %EBX,%EBX              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE c50 <baseline+0x90>      | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nPXOR %XMM0,%XMM0            | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nADD $0x8,%R15               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCVTSS2SD (%R14),%XMM0       | 2     | 1    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 1\nADD %RBP,%R14               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCALL 740 <@plt_start@+0x20> | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nMULSD -0x8(%R15),%XMM0      | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nMOVSD %XMM0,-0x8(%R15)      | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCMP %R12,%R15               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJNE c00 <baseline+0x40>     | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nADD $0x1,%EBX               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD $0x4,%R13               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCMP %EBX,0x4(%RSP)          | 1     | 0.25 | 0.25 | 0.50 | 0.50 | 0  | 0.25 | 0.25 | 0    | 1       | 0.50\nJNE bf8 <baseline+0x38>     | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nADD $0x18,%RSP              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nPOP %RBX\nPOP %RBP\nPOP %R12\nPOP %R13\nPOP %R14\nPOP %R15\nRET\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 43\nnb uops            : 32\nloop length        : 134\nused x86 registers : 11\nused mmx registers : 0\nused xmm registers : 1\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 2\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 8.00 cycles\nfront end            : 8.00 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7\n--------------------------------------------------------------\nuops   | 5.00 | 5.00 | 2.67 | 2.67 | 4.00 | 5.00 | 5.00 | 2.67\ncycles | 5.00 | 5.00 | 2.67 | 2.67 | 4.00 | 5.00 | 5.00 | 2.67\n\nCycles executing div or sqrt instructions: NA\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 8.00\nDispatch  : 5.00\nOverall L1: 8.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 10%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : 0%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 0%\nother  : 14%\nFP\nall    : 0%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 0%\nINT+FP\nall    : 7%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 12%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 22%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : 18%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 25%\nother  : 23%\nFP\nall    : 20%\nload   : 18%\nstore  : 25%\nmul    : 25%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 12%\nINT+FP\nall    : 22%\nload   : 18%\nstore  : 20%\nmul    : 25%\nadd-sub: 25%\nother  : 21%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each call to the function takes 8.00 cycles. At this rate:\n - 4% of peak load performance is reached (3.00 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 7% of peak store performance is reached (2.50 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 8.00 to 5.00 cycles (1.60x speedup).\n",
        },
      },
      header = {
        "Warnings:\n - The number of fused uops of the instruction [PUSH	%R15] is unknown\n - The number of fused uops of the instruction [PUSH	%R14] is unknown\n - The number of fused uops of the instruction [PUSH	%R13] is unknown\n - The number of fused uops of the instruction [PUSH	%R12] is unknown\n - The number of fused uops of the instruction [PUSH	%RBP] is unknown\n - The number of fused uops of the instruction [PUSH	%RBX] is unknown\n - The number of fused uops of the instruction [POP	%RBX] is unknown\n - The number of fused uops of the instruction [POP	%RBP] is unknown\n - The number of fused uops of the instruction [POP	%R12] is unknown\n - The number of fused uops of the instruction [POP	%R13] is unknown\n - The number of fused uops of the instruction [POP	%R14] is unknown\n - The number of fused uops of the instruction [POP	%R15] is unknown\n - The number of fused uops of the instruction [RET] is unknown\n - Detected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.\n",
        "0% of peak computational performance is used (0.12 out of 16.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 8.00 to 2.75 cycles (2.91x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one\n - Make array accesses unit-stride:\n  * If your function streams arrays of structures (AoS), try to use structures of arrays instead (SoA)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized function can use their full power.\n",
          title = "Vectorization",
          txt = "Your function is probably not vectorized.\nOnly 22% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your function, you can lower the cost of an iteration from 8.00 to 1.14 cycles (7.02x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
      },
    },
    {
      hint = {
        {
          workaround = "Pass to your compiler a micro-architecture specialization option:\n - Please read your compiler manual\n",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CALL: 1 occurrences\n - CVTSS2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - CVTSS2SD: 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "1 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your function (in the source code) and the binary function",
          txt = "The binary function is composed of 1 FP arithmetical operations:\n - 1: multiply\nThe binary function is loading 32 bytes (4 double precision FP elements).\nThe binary function is storing 28 bytes (3 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.02 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the function is: bc0\n\nInstruction                 | Nb FU | P0   | P1   | P2   | P3   | P4 | P5   | P6   | P7   | Latency | Recip. throughput\n-----------------------------------------------------------------------------------------------------------------------\nTEST %EDI,%EDI              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE c5c <baseline+0x9c>      | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nPUSH %R15\nLEA -0x1(%RDI),%EAX         | 1     | 0    | 0.50 | 0    | 0    | 0  | 0.50 | 0    | 0    | 1       | 0.50\nPUSH %R14\nPUSH %R13\nPUSH %R12\nMOV %RSI,%R13               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nPUSH %RBP\nPUSH %RBX\nMOV %EDI,%EBP               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nLEA 0x8(%RDX,%RAX,8),%R12   | 1     | 0    | 1    | 0    | 0    | 0  | 0    | 0    | 0    | 3       | 1\nSAL $0x2,%RBP               | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 1       | 0.50\nXOR %EBX,%EBX               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nSUB $0x18,%RSP              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nMOV %RDX,0x8(%RSP)          | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nMOV %EDI,0x4(%RSP)          | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nNOPW (%RAX,%RAX,1)          | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nMOV 0x8(%RSP),%R15          | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nMOV %R13,%R14               | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nTEST %EBX,%EBX              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJE c50 <baseline+0x90>      | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nPXOR %XMM0,%XMM0            | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 0    | 0    | 0       | 0.25\nADD $0x8,%R15               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCVTSS2SD (%R14),%XMM0       | 2     | 1    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 1\nADD %RBP,%R14               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCALL 740 <@plt_start@+0x20> | 2     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 1    | 0.33 | 0       | 2\nMULSD -0x8(%R15),%XMM0      | 1     | 0.50 | 0.50 | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 3       | 0.50\nMOVSD %XMM0,-0x8(%R15)      | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nCMP %R12,%R15               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nJNE c00 <baseline+0x40>     | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nADD $0x1,%EBX               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nADD $0x4,%R13               | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nCMP %EBX,0x4(%RSP)          | 1     | 0.25 | 0.25 | 0.50 | 0.50 | 0  | 0.25 | 0.25 | 0    | 1       | 0.50\nJNE bf8 <baseline+0x38>     | 1     | 0.50 | 0    | 0    | 0    | 0  | 0    | 0.50 | 0    | 0       | 0.50-1\nADD $0x18,%RSP              | 1     | 0.25 | 0.25 | 0    | 0    | 0  | 0.25 | 0.25 | 0    | 1       | 0.25\nPOP %RBX\nPOP %RBP\nPOP %R12\nPOP %R13\nPOP %R14\nPOP %R15\nRET\nMOV 0xf9(%RIP),%RAX         | 1     | 0    | 0    | 0.50 | 0.50 | 0  | 0    | 0    | 0    | 2       | 0.50\nMOV %RAX,(%R15)             | 1     | 0    | 0    | 0.33 | 0.33 | 1  | 0    | 0    | 0.33 | 3       | 1\nJMP c04 <baseline+0x44>     | 1     | 0    | 0    | 0    | 0    | 0  | 0    | 1    | 0    | 0       | 1-2\n",
        },
        {
          title = "General properties",
          txt = "nb instructions    : 46\nnb uops            : 35\nloop length        : 146\nused x86 registers : 11\nused mmx registers : 0\nused xmm registers : 1\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 2\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 8.75 cycles\nfront end            : 8.75 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | P0   | P1   | P2   | P3   | P4   | P5   | P6   | P7\n--------------------------------------------------------------\nuops   | 5.25 | 5.25 | 3.50 | 3.17 | 5.00 | 5.25 | 5.25 | 3.33\ncycles | 5.25 | 5.25 | 3.50 | 3.17 | 5.00 | 5.25 | 5.25 | 3.33\n\nCycles executing div or sqrt instructions: NA\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 8.75\nDispatch  : 5.25\nOverall L1: 8.75\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 9%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : 0%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 0%\nother  : 14%\nFP\nall    : 0%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 0%\nINT+FP\nall    : 7%\nload   : 0%\nstore  : 0%\nmul    : 0%\nadd-sub: 0%\nother  : 12%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 22%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : 20%\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 25%\nother  : 23%\nFP\nall    : 20%\nload   : 18%\nstore  : 25%\nmul    : 25%\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nother  : 12%\nINT+FP\nall    : 22%\nload   : 18%\nstore  : 21%\nmul    : 25%\nadd-sub: 25%\nother  : 21%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each call to the function takes 8.75 cycles. At this rate:\n - 5% of peak load performance is reached (3.66 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 10% of peak store performance is reached (3.20 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 8.75 to 5.25 cycles (1.67x speedup).\n",
        },
      },
      header = {
        "Warnings:\n - The number of fused uops of the instruction [PUSH	%R15] is unknown\n - The number of fused uops of the instruction [PUSH	%R14] is unknown\n - The number of fused uops of the instruction [PUSH	%R13] is unknown\n - The number of fused uops of the instruction [PUSH	%R12] is unknown\n - The number of fused uops of the instruction [PUSH	%RBP] is unknown\n - The number of fused uops of the instruction [PUSH	%RBX] is unknown\n - The number of fused uops of the instruction [POP	%RBX] is unknown\n - The number of fused uops of the instruction [POP	%RBP] is unknown\n - The number of fused uops of the instruction [POP	%R12] is unknown\n - The number of fused uops of the instruction [POP	%R13] is unknown\n - The number of fused uops of the instruction [POP	%R14] is unknown\n - The number of fused uops of the instruction [POP	%R15] is unknown\n - The number of fused uops of the instruction [RET] is unknown\n - Detected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.\n",
        "0% of peak computational performance is used (0.11 out of 16.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 8.75 to 2.75 cycles (3.18x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one\n - Make array accesses unit-stride:\n  * If your function streams arrays of structures (AoS), try to use structures of arrays instead (SoA)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized function can use their full power.\n",
          title = "Vectorization",
          txt = "Your function is probably not vectorized.\nOnly 22% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your function, you can lower the cost of an iteration from 8.75 to 1.26 cycles (6.94x speedup).",
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
      "This function has 3 execution paths.\n",
      "The presence of multiple execution paths is typically the main/first bottleneck.\nTry to simplify control inside function: ideally, try to remove all conditional expressions, for example by (if applicable):\n - hoisting them (moving them outside the function)\n - turning them into conditional moves, MIN or MAX\n\n",
    },
    nb_paths = 3,
  },
}