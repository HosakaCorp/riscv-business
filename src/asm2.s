.section .text
.globl _start
_start:
	li a0,0x0
	li a2,8
	#lui a1, %hi(msg)       # load msg(hi)
	#addi a1, a1, %lo(msg)  # load msg(lo)
	li 	a1,0x000a4141
	addi	sp,sp,-32
	sd	a1,32(sp)
	li	a1,0
	addi	a1,sp,32
	li a7, 64              # 64 is the __NR_write syscall 
	#ebreak
	ecall
	li a0, 0x0
	li a7, 93
	ecall

.section .rodata
msg:
	    .string "Hello MWR Labs\n\0"
