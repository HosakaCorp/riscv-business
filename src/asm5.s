.section .text
.globl _start
_start:
	    li a0, 0x0
	    li a7, 0x0
	    addi a7,a7,93
	    #li a7, 93
	    ecall
