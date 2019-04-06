.section .text
.globl _start
_start:
	li a0,0x0
	li a2,16
	# without using the li pseudo instruction load a1 with 0xcafebabe
	lui a1,0x33
	addi a1,a1,-1029
	slli a1,a1,0xe
	addi a1,a1,-1346
	ret
	#li a7, 64              # 64 is the __NR_write syscall 
	#ecall
	#li a0, 0x0
	#li a7, 93
	#ecall

.section .rodata
msg:
	    .string "Hello MWR Labs\n\0"
