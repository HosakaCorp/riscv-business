# Now the real fun begins, in order to use our shellcode examples in a
# traditional (and antiquated) input based buffer overflow we need to
# understand common restrictions for shellcode. These disallowed
# characters are often refered to as "badchars" that prevent the normal
# execution of code flow. The most common are null characters (\x00),
# new lines in web applications, and a bunch more that are dependent on
# specific use case restrictions.
#
# This example is an attempt to remove the null characters from asm1.s.
# The first steps to doing this are to examine what the output of the
# disassembly of asm1 using good old `objdump`. Below al lines ending in
# a `<` character indicate locations where null bytes exist:
#
# 10078:	00000513          	li	a0,0 	<
# 1007c:	00000893          	li	a7,0	<
# 10080:	05d88893          	addi	a7,a7,93
# 10084:	00000073          	ecall		<
#
# 4 instructions and 3 contain null characters. The solution for this is
# to write our shellcode with null characters in mind, restricting
# ourselves to instructions, registers, immediate values, and opcodes 
# that will not contain the bad characters. We will do this by hand the
# first time and then slowly start building a "dictionary" and
# eventually some simplistic tooling to handle transcoding.
#
# I will be treating ecall as a special case and will temporarily ignore
# the null characters until it become relevant.
#
# The fist step is to discover which opcodes corespond to usable
# instructions without nulls. Knowing that we have to clear some
# registers, it is clear that `li` actually has a null safe opcode
# (0x13), but the argument of 0 for it's immediate value always an
# immediate field containing nulls. You could do some tricky math to
# attempt to account for this, or we could check if there are any other
# instructions that can be use with both safe opcodes and arguments.
#
# My mind goes instantly to xor since xor'ing a value with itself always
# clears it. So to check the opcode safety I wrote a terrible script
# here: `utils/trashdis.sh` This piece of code compiles and objdumps a
# single passed instruction like so:
#
# ./util/trashdis.sh 'xor a0,a0,a0'
# 00a54533 xor a0,a0,a0
# ./util/trashfmt.py 0x00a54533
# 00000000 10100101 01000101 00110011
#
# Based on what we know about the register formats XOR is a R type
# instruction, meaning that the we know the how to make a decision on
# which arguments are causing the null characters. I played with this by
# doing the following:
#
# # ./trashfmt.py $(./trashdis.sh 'xor x0,x0,x0')
# 00000000 00000000 01000000 00110011
# # ./trashfmt.py $(./trashdis.sh 'xor x0,x0,x1')
# 00000000 00010000 01000000 00110011
# # ./trashfmt.py $(./trashdis.sh 'xor x0,x1,x0')
# 00000000 00000000 11000000 00110011
# # ./trashfmt.py $(./trashdis.sh 'xor x1,x0,x0')
# 00000000 00000000 01000000 10110011
# 
# A quick glance indicates that we need to get a value into the most
# significant bytes to get rid of the null. The R type instructions use
# the second argument (`rs2`) in bits 19-24, which means that we should
# be able to use x17 or greater in `rs2` to get 0x0001 just barely
# getting us by. This is due to the fact that helpfully the `xN`
# representation of the registers is also the hex value.
#
# If we look up the calling convention you will find that x17 is a7. 
# This can be tested by trying to clear a7 and passing it through the 
# trashutils:
#
# ./trashdis.sh 'xor a7,a7,a7'
# 0118c8b3 xor a7,a7,a7
# 
# Good, we were correct. Using the same xor trick we can also set 
# a0 (x10) by making it the destination register:
#
# # ./trashdis.sh 'xor a0,a7,a7'
# 0118c533 xor a0,a7,a7
#
# The final disassembly looks like this:
#
# 10078:	0118c8b3          	xor	a7,a7,a7
# 1007c:	0118c533          	xor	a0,a7,a7
# 10080:	05d88893          	addi	a7,a7,93
# 10084:	00000073          	ecall
#
# We can test what we have so far by compiling and running it. We will
# revist getting rid of the ecall null's later.
.section .text
.globl _start
_start:
	xor a7,a7,a7 # clear a7
	xor a0,a7,a7 # set a0 to 0
	addi a7,a7,93 # set syscall to exit(0)
	ecall
