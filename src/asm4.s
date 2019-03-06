.section .text
.globl _start
_start:
	    li a0,0x6e69622f #nib/
	    addi sp,sp,-8
	    sd a0,0(sp)
	    li a0,0x0068732f # \0hs/ 
	    sd a0,4(sp)
	    li a0,0
	    addi a0,sp,0
	    li a2,0x0
	    li a1,0x0
	    li a7, 221 #221 is the __NR_execve 
	    ecall
	    li a0, 0x0
	    li a7, 93
	    ecall
