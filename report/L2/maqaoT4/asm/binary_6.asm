0x1288::Insn: TEST	%RBX,%RBX
0x128b::Insn: JE	12d0 <baseline+0x80>
0x128d::Insn: PXOR	%XMM0,%XMM0
0x1291::Insn: CVTSS2SD	(%R12,%RBX,4),%XMM0
0x1297::Insn: ADD	$0x1,%RBX
0x129b::Insn: CALL	740 <@plt_start@+0x20>
0x12a0::Insn: MULSD	(%RBP),%XMM0
0x12a5::Insn: CMP	%RBX,%R13
0x12a8::Insn: MOVSD	%XMM0,(%RBP)
0x12ad::Insn: JNE	1288 <baseline+0x38>
0x12d0::Insn: PXOR	%XMM0,%XMM0
0x12d4::Insn: MOV	0x135(%RIP),%RDX
0x12db::Insn: CVTSS2SD	(%R12,%RBX,4),%XMM0
0x12e1::Insn: MOV	%RDX,(%RBP)
0x12e5::Insn: MOV	$0x1,%EBX
0x12ea::Insn: CALL	740 <@plt_start@+0x20>
0x12ef::Insn: MULSD	(%RBP),%XMM0
0x12f4::Insn: CMP	$0x1,%R13
0x12f8::Insn: MOVSD	%XMM0,(%RBP)
0x12fd::Insn: JNE	128d <baseline+0x3d>
