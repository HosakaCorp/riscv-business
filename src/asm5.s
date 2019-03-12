# 10078:	00000513          	li	a0,0
# 1007c:	00000893          	li	a7,0
# 10080:	05d88893          	addi	a7,a7,93
# 10084:	00000073          	ecall


# 10078:	0118c8b3          	xor	a7,a7,a7
# 1007c:	0118c533          	xor	a0,a7,a7
# 10080:	05d88893          	addi	a7,a7,93
# 10084:	00000073          	ecall
.section .text
.globl _start
_start:
	#li a0, 0x0
	#li a7, 0x0
	#addi a7,a7,93
	#ecall
	xor a7,a7,a7
	xor a0,a7,a7
	addi a7,a7,93
	ecall
