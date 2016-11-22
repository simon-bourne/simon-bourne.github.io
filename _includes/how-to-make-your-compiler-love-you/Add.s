	.file	"Add.cpp"
	.text
	.p2align 4,,15
	.globl	_ZN8Enhedron8Examples4Impl3addEPdS2_m
	.type	_ZN8Enhedron8Examples4Impl3addEPdS2_m, @function
_ZN8Enhedron8Examples4Impl3addEPdS2_m:
.LFB0:
	.cfi_startproc
	testq	%rdx, %rdx
	je	.L21
	leaq	32(%rsi), %rax
	cmpq	%rax, %rdi
	leaq	32(%rdi), %rax
	setae	%cl
	cmpq	%rax, %rsi
	setae	%al
	orb	%al, %cl
	je	.L3
	cmpq	$6, %rdx
	jbe	.L3
	movq	%rdx, %r9
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	shrq	$2, %r9
	leaq	0(,%r9,4), %r8
.L9:
	vmovupd	(%rdi,%rax), %xmm0
	addq	$1, %rcx
	vmovupd	(%rsi,%rax), %xmm1
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm0, %ymm0
	vinsertf128	$0x1, 16(%rsi,%rax), %ymm1, %ymm1
	vaddpd	%ymm0, %ymm1, %ymm0
	vmovupd	%xmm0, (%rsi,%rax)
	vextractf128	$0x1, %ymm0, 16(%rsi,%rax)
	addq	$32, %rax
	cmpq	%r9, %rcx
	jb	.L9
	cmpq	%r8, %rdx
	je	.L20
	leaq	(%rsi,%r8,8), %rax
	vmovsd	(%rax), %xmm0
	vaddsd	(%rdi,%r8,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax)
	leaq	1(%r8), %rax
	cmpq	%rax, %rdx
	jbe	.L20
	leaq	(%rsi,%rax,8), %rcx
	addq	$2, %r8
	cmpq	%r8, %rdx
	vmovsd	(%rcx), %xmm0
	vaddsd	(%rdi,%rax,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx)
	jbe	.L20
	leaq	(%rsi,%r8,8), %rax
	vmovsd	(%rax), %xmm0
	vaddsd	(%rdi,%r8,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax)
	vzeroupper
	ret
	.p2align 4,,10
	.p2align 3
.L20:
	vzeroupper
.L21:
	rep ret
	.p2align 4,,10
	.p2align 3
.L3:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L11:
	vmovsd	(%rsi,%rax,8), %xmm0
	vaddsd	(%rdi,%rax,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%rdx, %rax
	jne	.L11
	rep ret
	.cfi_endproc
.LFE0:
	.size	_ZN8Enhedron8Examples4Impl3addEPdS2_m, .-_ZN8Enhedron8Examples4Impl3addEPdS2_m
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
