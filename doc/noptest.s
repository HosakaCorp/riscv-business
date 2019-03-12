.section .text
.globl _start
_start:
	xor x0,x0,0
	xor x0,x0,1
	xor x0,x0,0xff
	and x0,x0,0	
	and x0,x0,1	
	and x0,x0,0xff	
	and x0,x0,x0	
	addi x0,x0,0
	addi x0,x0,1
	addi x0,x1,0
	addi x0,x1,1
	addi x0,x8,0
	addi x0,x8,1
	addi x0,x15,0
	addi x0,x15,1
	addi x0,x31,0
	addi x0,x31,1
	addiw x0,x0,0xff	
	rdcycle x0
	rdcycle x30
	#c.addi x17,1
	#c.addi x17,0x0
	li a0, 0x0
	li a7, 93
	#c.ebreak
	ecall
