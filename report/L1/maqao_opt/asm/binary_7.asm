0x1d13::Insn: VMOVSS	(%RBX,%R13,2),%XMM10
0x1d19::Insn: VMOVSS	(%RBX),%XMM12
0x1d1d::Insn: VMOVSS	(%R12,%R13,2),%XMM14
0x1d23::Insn: VMOVSS	(%R12),%XMM0
0x1d29::Insn: VINSERTPS	$0x10,(%RBX,%R15,1),%XMM10,%XMM11
0x1d30::Insn: VINSERTPS	$0x10,(%RBX,%R13,1),%XMM12,%XMM13
0x1d37::Insn: VINSERTPS	$0x10,(%R12,%R15,1),%XMM14,%XMM15
0x1d3e::Insn: VINSERTPS	$0x10,(%R12,%R13,1),%XMM0,%XMM2
0x1d45::Insn: VMOVLHPS	%XMM11,%XMM13,%XMM4
0x1d4a::Insn: VMOVLHPS	%XMM15,%XMM2,%XMM1
0x1d4f::Insn: VINSERTF128	$0x1,%XMM4,%YMM1,%YMM3
0x1d55::Insn: VCVTPS2PD	%XMM3,%YMM0
0x1d59::Insn: VMOVAPS	%YMM3,-0xb0(%RBP)
0x1d61::Insn: CALL	24b0 <_ZGVdN4v___exp_finite>
0x1d66::Insn: VMOVAPS	-0xb0(%RBP),%YMM5
0x1d6e::Insn: VMOVAPD	%YMM0,-0x90(%RBP)
0x1d76::Insn: VEXTRACTF128	$0x1,%YMM5,%XMM6
0x1d7c::Insn: VCVTPS2PD	%XMM6,%YMM0
0x1d80::Insn: CALL	24b0 <_ZGVdN4v___exp_finite>
0x1d85::Insn: MOV	-0x38(%RBP),%R9
0x1d89::Insn: VMOVAPD	-0x90(%RBP),%YMM8
0x1d91::Insn: ADD	%R9,%R12
0x1d94::Insn: ADD	%R9,%RBX
0x1d97::Insn: VMULPD	0x20(%R14),%YMM0,%YMM7
0x1d9d::Insn: VMULPD	(%R14),%YMM8,%YMM9
0x1da2::Insn: VMOVSS	(%RBX,%R13,2),%XMM10
0x1da8::Insn: VMOVSS	(%RBX),%XMM12
0x1dac::Insn: VMOVSS	(%R12,%R13,2),%XMM14
0x1db2::Insn: VMOVSS	(%R12),%XMM0
0x1db8::Insn: VINSERTPS	$0x10,(%RBX,%R15,1),%XMM10,%XMM11
0x1dbf::Insn: VINSERTPS	$0x10,(%R12,%R13,1),%XMM0,%XMM2
0x1dc6::Insn: VINSERTPS	$0x10,(%RBX,%R13,1),%XMM12,%XMM13
0x1dcd::Insn: VINSERTPS	$0x10,(%R12,%R15,1),%XMM14,%XMM15
0x1dd4::Insn: VMOVLHPS	%XMM11,%XMM13,%XMM4
0x1dd9::Insn: VMOVLHPS	%XMM15,%XMM2,%XMM1
0x1dde::Insn: VMOVUPD	%YMM9,(%R14)
0x1de3::Insn: VMOVUPD	%YMM7,0x20(%R14)
0x1de9::Insn: LEA	0x40(%R14),%R8
0x1ded::Insn: VINSERTF128	$0x1,%XMM4,%YMM1,%YMM3
0x1df3::Insn: MOV	%R8,-0x60(%RBP)
0x1df7::Insn: VCVTPS2PD	%XMM3,%YMM0
0x1dfb::Insn: VMOVAPS	%YMM3,-0xb0(%RBP)
0x1e03::Insn: CALL	24b0 <_ZGVdN4v___exp_finite>
0x1e08::Insn: VMOVAPS	-0xb0(%RBP),%YMM5
0x1e10::Insn: VMOVAPD	%YMM0,-0x90(%RBP)
0x1e18::Insn: VEXTRACTF128	$0x1,%YMM5,%XMM6
0x1e1e::Insn: VCVTPS2PD	%XMM6,%YMM0
0x1e22::Insn: CALL	24b0 <_ZGVdN4v___exp_finite>
0x1e27::Insn: MOV	-0x60(%RBP),%R11
0x1e2b::Insn: VMOVAPD	-0x90(%RBP),%YMM8
0x1e33::Insn: VMULPD	0x20(%R11),%YMM0,%YMM7
0x1e39::Insn: VMULPD	0x40(%R14),%YMM8,%YMM9
0x1e3f::Insn: SUB	$-0x80,%R14
0x1e43::Insn: VMOVUPD	%YMM9,-0x40(%R14)
0x1e49::Insn: VMOVUPD	%YMM7,0x20(%R11)
0x1e4f::Insn: MOV	-0x38(%RBP),%R10
0x1e53::Insn: ADD	%R10,%R12
0x1e56::Insn: ADD	%R10,%RBX
0x1e59::Insn: CMP	-0x48(%RBP),%R14
0x1e5d::Insn: JNE	1d13 <baseline+0x1a3>