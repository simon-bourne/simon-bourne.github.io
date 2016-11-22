	.file	"AddStrict.cpp"
	.text
	.p2align 4,,15
	.globl	_ZN8Enhedron8Examples4Impl9addStrictEPdS2_m
	.type	_ZN8Enhedron8Examples4Impl9addStrictEPdS2_m, @function
_ZN8Enhedron8Examples4Impl9addStrictEPdS2_m:
.LFB4:
	.cfi_startproc
	leaq	(%rsi,%rdx,8), %rax
	.p2align 4,,10
	.p2align 3
.L3:
	vmovapd	(%rsi), %ymm0
	addq	$32, %rsi
	addq	$32, %rdi
	vaddpd	-32(%rdi), %ymm0, %ymm0
	vmovapd	%ymm0, -32(%rsi)
	cmpq	%rax, %rsi
	jne	.L3
	vzeroupper
	ret
	.cfi_endproc
.LFE4:
	.size	_ZN8Enhedron8Examples4Impl9addStrictEPdS2_m, .-_ZN8Enhedron8Examples4Impl9addStrictEPdS2_m
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
