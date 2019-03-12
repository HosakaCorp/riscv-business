# This example expands on the last one by using the "write" system call 
# to print the strings using two different mechanisms. Only the first
# example should be useful for shellcoding, but the second is important
# to demonstrate how the 32-bit registers have restrictions and how to
# work with them in a position independent manner.
#
# We will print the strings:
# - AA\n\0
# - Hello MWR Labs\n\0
# 
# The first step to this is to load the values we want to print on the 
# stack using their literal values in little endian, load the other
# arguments, and call the system call like in the previous example.
# 
# This gets a bit more complicated when you realize that the `li`
# pseudoinstruction generates code differently for values greater than
# 1048575 (0xFFFFF). This is due to the fact that loading the immediate
# upper value being a U-type instruction can only take 20 bits and the
# rest of the expected 12 bits will have to be ADDI'd afterward.
#
# Remember the U-type format is imm[31:12] | rd | opcode
#
# As an example, `li a1,0xFFFFF000` will generate code as:
# > lui a1,1048575
#
# Whereas attempting to use `li a1,0x000a4141` will generate:
# > lui a1,0xa4 # 0x000a4 - Upper 20 bits
# > addiw a1,a1,321 # 0x141 - lower 12 bits
# 
# This can cause issues and make things a bit hard to predict the output
# of the assembler, so be aware when writing the assembly.
# 
# The second part of achieves the same thing as the first but uses the
# assembler macro (TODO right verbiage?) for loading the upper portion
# of the text and then the lower. This is very useful when hand writing
# asm, but not very useful for shellcoding.
#
# An additional note, the `ebreak` instruction will trigger a gdb trap
# and will allow you to debug incredibly easily. I used this very
# heavily during development to better understand. If your VM supports
# gdb, I highly suggest exploring the register (`i r`), stack (`i
# stack`), and stepping through instructions (`stepi`).
.section .text
.globl _start
_start:
	li a0,0x0	#first argument: file descriptor STDOUT
	addi sp,sp,-4	#move stack pointer down 4 bytes
	li a1,0x000a4141#Literal AA\n\0 in little endian
	sd a1,4(sp)	#store AA\n\0 sp+4 (orignal sp value)
	li a1,0		#zero out the a1 register for the next instruction
	addi a1,sp,4	#second argument: address of sp+4 (original sp value)
	li a2,4		#third argument: 4 byte size of buffer
	li a7, 64       #64 is the __NR_write syscall 
	#ebreak
	ecall		#system call
	li a0,0x0 	#first argument: file descriptor STDOUT
	addi	sp,sp,-16 #move stack pointer down 16 bytes
	lui a1, %hi(msg)	#load msg(upper 20 bits)
	addi a1, a1, %lo(msg)	#load msg(lower 12 bits)
	li a2,17	#third argument: 16 byte size of buffer
	ecall		#a7 is still loaded with write syscall
	li a0, 0x0
	li a7, 93
	ecall

.section .rodata
msg:
	    .string "Hello MWR Labs\n\0"
