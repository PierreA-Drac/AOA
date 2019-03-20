_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n<ul><li>CALL: 4 occurrences</li><li>VCVTPS2PD: 4 occurrences</li><li>VINSERTPS: 8 occurrences</li></ul>",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "<ul><li>Recompile with march=skylake.\nCQA target is Skylake_4e (6th generation Intel Core processors and Intel Xeon processor E3-1500m v5 product family and E3-1200 v5 product family based on Skylake microarchitecture) but specialization flags are -march=x86-64</li><li>Use vector aligned instructions:\n<ol><li>align your arrays on 32 bytes boundaries: replace { void *p = malloc (size); } with { void *p; posix_memalign (&amp;p, 32, size); }.</li><li>inform your compiler that your arrays are vector aligned: if array 'foo' is 32 bytes-aligned, define a pointer 'p_foo' as __builtin_assume_aligned (foo, 32) and use it instead of 'foo' in the loop.</li></ol></li></ul>",
          details = "<ul><li>VEXTRACTF128: 2 occurrences</li><li>VINSERTF128: 2 occurrences</li></ul>",
          title = "Vector unaligned load/store instructions",
          txt = "Detected 4 suboptimal vector unaligned load/store instructions.\n",
        },
        {
          workaround = "Use double instead of single precision only when/where needed by numerical stability and avoid mixing data with different types. In particular, check if the type of constants is the same as array elements. In C/C++, FP constants are double precision by default and must be suffixed by 'f' to make them single precision.",
          details = "<ul><li>VCVTPS2PD: 4 occurrences</li></ul>",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions (typically from/to single/double precision).",
        },
        {
          title = "Type of elements and instruction set",
          txt = "4 AVX instructions are processing arithmetic or math operations on double precision FP elements in vector mode (four at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 16 FP arithmetical operations:\n<ul><li>16: multiply</li></ul>The binary loop is loading 352 bytes (44 double precision FP elements).\nThe binary loop is storing 264 bytes (33 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.03 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1d13\n\n<table><tr><th>Instruction</th><th>Nb FU</th><th>P0</th><th>P1</th><th>P2</th><th>P3</th><th>P4</th><th>P5</th><th>P6</th><th>P7</th><th>Latency</th><th>Recip. throughput</th></tr><tr><td>VMOVSS (%RBX,%R13,2),%XMM10</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%RBX),%XMM12</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%R12,%R13,2),%XMM14</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%R12),%XMM0</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VINSERTPS $0x10,(%RBX,%R15,1),%XMM10,%XMM11</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%RBX,%R13,1),%XMM12,%XMM13</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%R12,%R15,1),%XMM14,%XMM15</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%R12,%R13,1),%XMM0,%XMM2</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VMOVLHPS %XMM11,%XMM13,%XMM4</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td></tr><tr><td>VMOVLHPS %XMM15,%XMM2,%XMM1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td></tr><tr><td>VINSERTF128 $0x1,%XMM4,%YMM1,%YMM3</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>3</td><td>1</td></tr><tr><td>VCVTPS2PD %XMM3,%YMM0</td><td>2</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>7</td><td>1</td></tr><tr><td>VMOVAPS %YMM3,-0xb0(%RBP)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>CALL 24b0 <_ZGVdN4v___exp_finite></td><td>2</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>1</td><td>0.33</td><td>0</td><td>2</td></tr><tr><td>VMOVAPS -0xb0(%RBP),%YMM5</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>3</td><td>0.50</td></tr><tr><td>VMOVAPD %YMM0,-0x90(%RBP)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>VEXTRACTF128 $0x1,%YMM5,%XMM6</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>3</td><td>1</td></tr><tr><td>VCVTPS2PD %XMM6,%YMM0</td><td>2</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>7</td><td>1</td></tr><tr><td>CALL 24b0 <_ZGVdN4v___exp_finite></td><td>2</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>1</td><td>0.33</td><td>0</td><td>2</td></tr><tr><td>MOV -0x38(%RBP),%R9</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0.50</td></tr><tr><td>VMOVAPD -0x90(%RBP),%YMM8</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>3</td><td>0.50</td></tr><tr><td>ADD %R9,%R12</td><td>1</td><td>0.25</td><td>0.25</td><td>0</td><td>0</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.25</td></tr><tr><td>ADD %R9,%RBX</td><td>1</td><td>0.25</td><td>0.25</td><td>0</td><td>0</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.25</td></tr><tr><td>VMULPD 0x20(%R14),%YMM0,%YMM7</td><td>1</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>4</td><td>0.50</td></tr><tr><td>VMULPD (%R14),%YMM8,%YMM9</td><td>1</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>4</td><td>0.50</td></tr><tr><td>VMOVSS (%RBX,%R13,2),%XMM10</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%RBX),%XMM12</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%R12,%R13,2),%XMM14</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VMOVSS (%R12),%XMM0</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td></tr><tr><td>VINSERTPS $0x10,(%RBX,%R15,1),%XMM10,%XMM11</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%R12,%R13,1),%XMM0,%XMM2</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%RBX,%R13,1),%XMM12,%XMM13</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VINSERTPS $0x10,(%R12,%R15,1),%XMM14,%XMM15</td><td>2</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>1</td><td>0</td><td>0</td><td>4</td><td>1</td></tr><tr><td>VMOVLHPS %XMM11,%XMM13,%XMM4</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td></tr><tr><td>VMOVLHPS %XMM15,%XMM2,%XMM1</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td></tr><tr><td>VMOVUPD %YMM9,(%R14)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>VMOVUPD %YMM7,0x20(%R14)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>LEA 0x40(%R14),%R8</td><td>1</td><td>0</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0.50</td><td>0</td><td>0</td><td>1</td><td>0.50</td></tr><tr><td>VINSERTF128 $0x1,%XMM4,%YMM1,%YMM3</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>3</td><td>1</td></tr><tr><td>MOV %R8,-0x60(%RBP)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>VCVTPS2PD %XMM3,%YMM0</td><td>2</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>7</td><td>1</td></tr><tr><td>VMOVAPS %YMM3,-0xb0(%RBP)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>CALL 24b0 <_ZGVdN4v___exp_finite></td><td>2</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>1</td><td>0.33</td><td>0</td><td>2</td></tr><tr><td>VMOVAPS -0xb0(%RBP),%YMM5</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>3</td><td>0.50</td></tr><tr><td>VMOVAPD %YMM0,-0x90(%RBP)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>VEXTRACTF128 $0x1,%YMM5,%XMM6</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>3</td><td>1</td></tr><tr><td>VCVTPS2PD %XMM6,%YMM0</td><td>2</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>7</td><td>1</td></tr><tr><td>CALL 24b0 <_ZGVdN4v___exp_finite></td><td>2</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>1</td><td>0.33</td><td>0</td><td>2</td></tr><tr><td>MOV -0x60(%RBP),%R11</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0.50</td></tr><tr><td>VMOVAPD -0x90(%RBP),%YMM8</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>3</td><td>0.50</td></tr><tr><td>VMULPD 0x20(%R11),%YMM0,%YMM7</td><td>1</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>4</td><td>0.50</td></tr><tr><td>VMULPD 0x40(%R14),%YMM8,%YMM9</td><td>1</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>4</td><td>0.50</td></tr><tr><td>SUB $-0x80,%R14</td><td>1</td><td>0.25</td><td>0.25</td><td>0</td><td>0</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.25</td></tr><tr><td>VMOVUPD %YMM9,-0x40(%R14)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>VMOVUPD %YMM7,0x20(%R11)</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>0.33</td><td>1</td><td>0</td><td>0</td><td>0.33</td><td>3</td><td>1</td></tr><tr><td>MOV -0x38(%RBP),%R10</td><td>1</td><td>0</td><td>0</td><td>0.50</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>2</td><td>0.50</td></tr><tr><td>ADD %R10,%R12</td><td>1</td><td>0.25</td><td>0.25</td><td>0</td><td>0</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.25</td></tr><tr><td>ADD %R10,%RBX</td><td>1</td><td>0.25</td><td>0.25</td><td>0</td><td>0</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.25</td></tr><tr><td>CMP -0x48(%RBP),%R14</td><td>1</td><td>0.25</td><td>0.25</td><td>0.50</td><td>0.50</td><td>0</td><td>0.25</td><td>0.25</td><td>0</td><td>1</td><td>0.50</td></tr><tr><td>JNE 1d13 <baseline+0x1a3></td><td>1</td><td>0.50</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0.50</td><td>0</td><td>0</td><td>0.50-1</td></tr></table>",
        },
        {
          title = "General properties",
          txt = "<table><tr><td>nb instructions</td><td>60</td></tr><tr><td>nb uops</td><td>75</td></tr><tr><td>loop length</td><td>336</td></tr><tr><td>used x86 registers</td><td>10</td></tr><tr><td>used mmx registers</td><td>0</td></tr><tr><td>used xmm registers</td><td>12</td></tr><tr><td>used ymm registers</td><td>7</td></tr><tr><td>used zmm registers</td><td>0</td></tr><tr><td>nb stack references</td><td>5</td></tr></table>",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\n<table><tr><td>micro-operation queue</td><td>12.50 cycles</td></tr><tr><td>front end</td><td>12.50 cycles</td></tr></table>",
        },
        {
          title = "Back-end",
          txt = "<table><tr><th>      </th><th>P0</th><th>P1</th><th>P2</th><th>P3</th><th>P4</th><th>P5</th><th>P6</th><th>P7</th></tr><tr><td>uops</td><td>6.50</td><td>6.25</td><td>14.00</td><td>14.00</td><td>13.00</td><td>20.00</td><td>6.25</td><td>13.00</td></tr><tr><td>cycles</td><td>6.50</td><td>6.25</td><td>14.00</td><td>14.00</td><td>13.00</td><td>20.00</td><td>6.25</td><td>13.00</td></tr></table>\n<table><tr><td>Cycles executing div or sqrt instructions</td><td>NA</td></tr><tr><td>Longest recurrence chain latency (RecMII)</td><td>2.00</td></tr></table>",
        },
        {
          title = "Cycles summary",
          txt = "<table><tr><td>Front-end</td><td>12.50</td></tr><tr><td>Dispatch</td><td>20.00</td></tr><tr><td>Data deps.</td><td>2.00</td></tr><tr><td>Overall L1</td><td>20.00</td></tr></table>",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\n<table><tr><td>all</td><td>0%</td></tr><tr><td>load</td><td>0%</td></tr><tr><td>store</td><td>0%</td></tr><tr><td>mul</td><td>NA (no mul vectorizable/vectorized instructions)</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>NA (no other vectorizable/vectorized instructions)</td></tr></table>FP\n<table><tr><td>all</td><td>63%</td></tr><tr><td>load</td><td>33%</td></tr><tr><td>store</td><td>100%</td></tr><tr><td>mul</td><td>100%</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>60%</td></tr></table>INT+FP\n<table><tr><td>all</td><td>59%</td></tr><tr><td>load</td><td>30%</td></tr><tr><td>store</td><td>88%</td></tr><tr><td>mul</td><td>100%</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>60%</td></tr></table>",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\n<table><tr><td>all</td><td>25%</td></tr><tr><td>load</td><td>25%</td></tr><tr><td>store</td><td>25%</td></tr><tr><td>mul</td><td>NA (no mul vectorizable/vectorized instructions)</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>NA (no other vectorizable/vectorized instructions)</td></tr></table>FP\n<table><tr><td>all</td><td>52%</td></tr><tr><td>load</td><td>41%</td></tr><tr><td>store</td><td>100%</td></tr><tr><td>mul</td><td>100%</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>30%</td></tr></table>INT+FP\n<table><tr><td>all</td><td>50%</td></tr><tr><td>load</td><td>40%</td></tr><tr><td>store</td><td>91%</td></tr><tr><td>mul</td><td>100%</td></tr><tr><td>add-sub</td><td>NA (no add-sub vectorizable/vectorized instructions)</td></tr><tr><td>other</td><td>30%</td></tr></table>",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 20.00 cycles. At this rate:\n<ul><li>27% of peak load performance is reached (17.60 out of 64.00 bytes loaded per cycle (GB/s @ 1GHz))</li><li>41% of peak store performance is reached (13.20 out of 32.00 bytes stored per cycle (GB/s @ 1GHz))</li></ul>",
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
          workaround = "<ul><li>Try another compiler or update/tune your current one:\n<ul><li>recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.</li></ul></li><li>Remove inter-iterations dependences from your loop and make it unit-stride:\n<ul><li>If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) =&gt; for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)</li><li>If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) =&gt; for(i) a.x[i] = b.x[i]; (fast, stride 1)</li></ul></li></ul>",
          details = "59% of SSE/AVX instructions are used in vector version (process two or more data elements in vector registers):\n<ul><li>30% of SSE/AVX loads are used in vector version.</li><li>88% of SSE/AVX stores are used in vector version.</li><li>60% of SSE/AVX instructions that are not load, store, addition, subtraction nor multiply instructions are used in vector version.</li></ul>Since your execution units are vector units, only a fully vectorized loop can use their full power.\n",
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
