	.file	"AddAligned.cpp"
	.text
	.p2align 4,,15
	.globl	_ZN8Enhedron8Examples4Impl10addAlignedEPdS2_m
	.type	_ZN8Enhedron8Examples4Impl10addAlignedEPdS2_m, @function
_ZN8Enhedron8Examples4Impl10addAlignedEPdS2_m:
.LFB4:
	.cfi_startproc
	leaq	(%rsi,%rdx,8), %rax
	.p2align 4,,10
	.p2align 3
.L3:
	vmovsd	(%rsi), %xmm0
	addq	$32, %rsi
	addq	$32, %rdi
	vaddsd	-32(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -32(%rsi)
	vmovsd	-24(%rsi), %xmm0
	vaddsd	-24(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -24(%rsi)
	vmovsd	-16(%rsi), %xmm0
	vaddsd	-16(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -16(%rsi)
	vmovsd	-8(%rsi), %xmm0
	vaddsd	-8(%rdi), %xmm0, %xmm0
	vmovsd	%xmm0, -8(%rsi)
	cmpq	%rax, %rsi
	jne	.L3
	rep ret
	.cfi_endproc
.LFE4:
	.size	_ZN8Enhedron8Examples4Impl10addAlignedEPdS2_m, .-_ZN8Enhedron8Examples4Impl10addAlignedEPdS2_m
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
