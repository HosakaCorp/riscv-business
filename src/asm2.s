#lui sets the upper immediate 0xFFFFF000 since the instruction format is imm[31:12] | rd | opcode
#then you have to load the lower 12 bytes 0x00000FFF (with addi)
#>>> hex(0x00010098)
#'0x10098'

.section .text
.globl _start
_start:
	addi	sp,sp,-4 #move stack pointer down 4 bytes
	#addi	sp,sp,-32 #move stack pointer down 4 bytes
	li a0,0x0 #first argument: file descriptor STDOUT
	li a2,4   #third argument: 4 byte size of buffer
	#li a2,32   #third argument: 4 byte size of buffer
	#lui a1, %hi(msg)       # load msg(hi)
	#addi a1, a1, %lo(msg)  # load msg(lo)
	li 	a1,0x000a4141 #Literal AA\n\0 in little endian
	sd	a1,4(sp) #store AA\n\0 sp+4 (orignal sp value)
	li	a1,0 #zero out the a1 register for the next instruction
	addi	a1,sp,4 #second argument: address of sp+4 (original sp value)
	li a7, 64              # 64 is the __NR_write syscall 
	#ebreak
	ecall
	li a0, 0x0
	li a7, 93
	ecall

.section .rodata
msg:
	    .string "Hello MWR Labs\n\0"
