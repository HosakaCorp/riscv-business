.section .text
.globl _start
_start:
	    li a1,0x0
	    li a2,0x0
	    lui a0,       %hi(msg)       # load msg(hi)
	    addi a0, a0,  %lo(msg)       # load msg(lo)
	    li a7, 221 #221 is the __NR_execve 
	    ecall
	    li a0, 0x0
	    li a7, 93
	    ecall

.section .rodata
msg:
	    .string "/bin/sh\0"
