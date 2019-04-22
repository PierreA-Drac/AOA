0x1508::Insn: MOV	%RAX,%RBX
0x150b::Insn: TEST	%RBX,%RBX
0x150e::Insn: JNE	151b <baseline+0x4b>
0x1510::Insn: MOV	0xb49(%RIP),%RAX
0x1517::Insn: MOV	%RAX,(%RBP)
0x151b::Insn: PXOR	%XMM0,%XMM0
0x151f::Insn: CVTSS2SD	(%R12,%RBX,4),%XMM0
0x1525::Insn: CALL	1040 <exp@plt>
0x152a::Insn: MULSD	(%RBP),%XMM0
0x152f::Insn: LEA	0x1(%RBX),%RAX
0x1533::Insn: MOVSD	%XMM0,(%RBP)
0x1538::Insn: CMP	%R13,%RBX
0x153b::Insn: JNE	1508 <baseline+0x38>
