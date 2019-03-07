.section .text
.globl _start
_start:
	li 	a0,0x0 #first argument: 
	li 	a2,8
	li	a1,0
	li 	t0,0x0a414141
	li	t1,0x42424242
	addi	sp,sp,-8
	sd	t1,0(sp)
	sd	t0,4(sp)
	addi	a1,sp,0
	li 	a7, 64              # 64 is the __NR_write syscall 
	ecall
	li 	a0, 0x0
	li 	a7, 93
	ecall
