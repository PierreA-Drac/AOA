0x1510::Insn: TEST	%EBX,%EBX
0x1512::Insn: JNE	151e <baseline+0x4e>
0x1514::Insn: MOV	0xb45(%RIP),%RAX
0x151b::Insn: MOV	%RAX,(%R15)
0x151e::Insn: MOVSS	(%R14),%XMM0
0x1523::Insn: ADD	$0x8,%R15
0x1527::Insn: ADD	%RBP,%R14
0x152a::Insn: CALL	1040 <expf@plt>
0x152f::Insn: CVTSS2SD	%XMM0,%XMM0
0x1533::Insn: MULSD	-0x8(%R15),%XMM0
0x1539::Insn: MOVSD	%XMM0,-0x8(%R15)
0x153f::Insn: CMP	%R15,%R12
0x1542::Insn: JNE	1510 <baseline+0x40>
