/*
0000000000010078 <_start>:
   10078:	451d                	li	a0,7
   1007a:	05d00893          	li	a7,93
   1007e:	00000073          	ecall
*/   

/*
0000000000012000 <code>:
   12000:       4501                    li      a0,0
   12002:       4881                    li      a7,0
   12004:       05d88893                addi    a7,a7,93
   12008:                       ecall

 */
const unsigned char code[] = "\x01\x45\x81\x48\x93\x88\xd8\x05\x73";