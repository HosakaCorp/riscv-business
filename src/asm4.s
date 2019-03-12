# This is the last example of simple assembly that we will write, it is
# a simple call to execve(2) to call /bin/sh. At this point we are still
# no writing any shellcode, but still familiarizing ourselves with using
# position independent code and some of the assembly pain points.
#
# We will simply uses the same techniques as before to make a call to
# execve in order to execute a shell. This combines all that we have
# learned so far and requires the following signature be matched from
# the execve documentation:
#
# execve(const char *filename, char *const argv[],char *const envp[]);
#
# While at first this might be intimidating, but just like with the
# write example all we need to do is set up the stack to contain the
# /bin/sh filename and use the trick of setting the other arguments to 0
# making them NULL values.
.section .text
.globl _start
_start:
	    #execve(*filename, *argv[], *envp[])
	    li a0,0x6e69622f	#nib/
	    addi sp,sp,-8	#set up the stack
	    sd a0,0(sp)		#store '/bin'
	    li a0,0x0068732f 	#\0hs/ 
	    sd a0,4(sp)		#store '/sh\0'
	    addi a0,sp,0	#set a0 to the top of the stack
	    li a2,0x0		#set argv[] to NULL
	    li a1,0x0		#set envp[] to NULL
	    li a7, 221 		#221 is the __NR_execve 
	    ecall
	    li a7, 93		#exit value of execve is in a0
	    ecall		#exit the program with the retval of execve
