.section .text
.globl _start
_start:
	    li a0,0x0
	    li a2,13
	    lui a1,       %hi(msg)       # load msg(hi)
	    addi a1, a1,  %lo(msg)       # load msg(lo)
	    li a7, 64 #64 is the __NR_write syscall 
	    ecall
	    li a0, 0x7
	    li a7, 93
	    ecall
	    #ret
#2:	    j 2b

.section .rodata
msg:
	    .string "Hello World\n\0"
