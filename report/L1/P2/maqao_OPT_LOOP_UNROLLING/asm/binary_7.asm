0x1558::Insn: TEST	%RBP,%RBP
0x155b::Insn: JNE	156b <baseline+0x9b>
0x155d::Insn: MOV	0xafc(%RIP),%RAX
0x1564::Insn: MOV	%RAX,(%R15)
0x1567::Insn: MOV	%RAX,0x8(%R15)
0x156b::Insn: PXOR	%XMM0,%XMM0
0x156f::Insn: ADD	$0x10,%R15
0x1573::Insn: CVTSS2SD	(%RBX),%XMM0
0x1577::Insn: CALL	1040 <exp@plt>
0x157c::Insn: MULSD	-0x10(%R15),%XMM0
0x1582::Insn: MOVSD	%XMM0,-0x10(%R15)
0x1588::Insn: PXOR	%XMM0,%XMM0
0x158c::Insn: CVTSS2SD	(%RBX,%R12,4),%XMM0
0x1592::Insn: CALL	1040 <exp@plt>
0x1597::Insn: ADD	%R14,%RBX
0x159a::Insn: MULSD	-0x8(%R15),%XMM0
0x15a0::Insn: MOVSD	%XMM0,-0x8(%R15)
0x15a6::Insn: CMP	%R13,%R15
0x15a9::Insn: JNE	1558 <baseline+0x88>
