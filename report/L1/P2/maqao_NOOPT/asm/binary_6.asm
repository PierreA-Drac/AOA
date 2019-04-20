0x1510::Insn: TEST	%EBX,%EBX
0x1512::Insn: JNE	151e <baseline+0x4e>
0x1514::Insn: MOV	0xb45(%RIP),%RAX
0x151b::Insn: MOV	%RAX,(%R15)
0x151e::Insn: PXOR	%XMM0,%XMM0
0x1522::Insn: ADD	$0x8,%R15
0x1526::Insn: CVTSS2SD	(%R14),%XMM0
0x152b::Insn: CALL	1040 <exp@plt>
0x1530::Insn: MULSD	-0x8(%R15),%XMM0
0x1536::Insn: ADD	%RBP,%R14
0x1539::Insn: MOVSD	%XMM0,-0x8(%R15)
0x153f::Insn: CMP	%R15,%R12
0x1542::Insn: JNE	1510 <baseline+0x40>
