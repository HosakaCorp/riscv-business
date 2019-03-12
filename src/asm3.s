# This example is pretty much the same as the last, but provides the
# oppurtunity to discuss why we should structure assembly for shellcode
# in a certain manner. One of the first concepts that we are going to
# need is Position Independent Code (PIC). In our last example our long
# string that we printed was read from the .rodata section of the ELF,
# which means that the data is written to the corresponding binary
# itself and either statically referenced or at run time a virtual
# address is generated.
#
# It may not be immediately obvious, but the behavior of having strings
# hardcoded in object sections means that we are not able to reliably
# reuse them in a generic manner when injecting the shellcode into a
# vulnerable target. We now have the restriction of making all the
# shellcode not reference static locations, we can't use labels, can
# only use relative jumps, and are restricted from using library
# functions. Up until this point we were functionally doing that anyway
# based on the simple nature of our programs, but a real assembly
# programmer would most likely be taking more advantage of this.
#
.section .text
.globl _start
_start:
	li 	a0,0x0	#first argument: fd 0 = STDOUT 
	li 	a2,8	#third argument: sizeof(a1)
	li 	t0,0x0a414141	#example of using temporary registers
	li	t1,0x42424242
	addi	sp,sp,-8	#move the stack down sizeof(t0+t1)
	sd	t1,0(sp)	#store 'BBBB'
	sd	t0,4(sp)	#store 'AAA\n'
	addi	a1,sp,0		#point a1 to the top of the stack
	li 	a7, 64		#64 is the __NR_write syscall 
	ecall
	li 	a7, 93		#exit with retval of previous syscall
	ecall
