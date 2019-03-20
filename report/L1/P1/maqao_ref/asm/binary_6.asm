0x1570::Insn: TEST	%EBX,%EBX
0x1572::Insn: JNE	157e <baseline+0x4e>
0x1574::Insn: MOV	0xae5(%RIP),%RAX
0x157b::Insn: MOV	%RAX,(%R15)
0x157e::Insn: PXOR	%XMM0,%XMM0
0x1582::Insn: ADD	$0x8,%R15
0x1586::Insn: CVTSS2SD	(%R14),%XMM0
0x158b::Insn: CALL	1040 <exp@plt>
0x1590::Insn: MULSD	-0x8(%R15),%XMM0
0x1596::Insn: ADD	%RBP,%R14
0x1599::Insn: MOVSD	%XMM0,-0x8(%R15)
0x159f::Insn: CMP	%R15,%R12
0x15a2::Insn: JNE	1570 <baseline+0x40>
