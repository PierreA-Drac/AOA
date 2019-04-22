0x1578::Insn: TEST	%R12D,%R12D
0x157b::Insn: JNE	1587 <baseline._omp_fn.0+0x87>
0x157d::Insn: MOV	0xadc(%RIP),%RAX
0x1584::Insn: MOV	%RAX,(%RBX)
0x1587::Insn: PXOR	%XMM0,%XMM0
0x158b::Insn: ADD	$0x8,%RBX
0x158f::Insn: CVTSS2SD	(%RBP),%XMM0
0x1594::Insn: CALL	1040 <exp@plt>
0x1599::Insn: MULSD	-0x8(%RBX),%XMM0
0x159e::Insn: ADD	%R13,%RBP
0x15a1::Insn: MOVSD	%XMM0,-0x8(%RBX)
0x15a6::Insn: CMP	%R14,%RBX
0x15a9::Insn: JNE	1578 <baseline._omp_fn.0+0x78>
