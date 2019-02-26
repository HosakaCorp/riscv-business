.section .text
.globl _start
_start:
	# This first example is a simple system call that triggers is an exit(7).
	# Based on the documentation in syscall(2) - a7 will hold the exit syscall and a0 will be the initial first argument and will also hold the return value from the syscall after execution
	# ecall is the replacement for scall that might be seen in earlier versions of the RISC-V ISA
	li a0, 0x7	# set the first exit(2) argument to 7
	li a7, 93	# 93 is the __NR_exit syscall
	ecall		# trigger system call
