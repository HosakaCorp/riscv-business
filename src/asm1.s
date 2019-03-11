# This first example is a simple system call that triggers is a exit(7);
#
# The first step is to get a handle on the RISC-V instructions from the
# ISA documentation and to understand how the different instructions are
# formated. The spec can be found here and is fairly readable: 
#
# https://github.com/riscv/riscv-isa-manual/releases/download/draft-20190309-ceb9d83/riscv-spec.pdf 
#
# There are 32 registers (and a program counter) and contain 4 core
# instruction formats (refered to as R, I, S, and U-type) and 2
# "immediate" instruction formats (B, J-type). The types of registers
# determine the format of the instructions, which can be a bit
# confusing, but the machine readable format looks like the following.
# NOTE: Remember this is little endian:
#
# SEE Section 25.1 in the ISA: Figure 25.1
# 
# There are additional extensions to the 32-bit core that are relevant
# since we are looking at the 64-bit little endian version specifically
# (RV64G). These define even more instructions for 64-bit support and is
# important to understand that different CPU's support even more
# extensions: * M - Integer multiplication and division * A - Atomic
# instructions * F - Single-precision floating point * D -
# Double-precision floating point * Q - Quad-precision floating point *
# L - Decimal floating point * C - Compressed instructions * B - Bit
# manipulation * J - Dynamically translated languages * T -
# Transactional memory * P - Packed-SIMD * V - Vector operations * N -
# User-level interrupts * "Zicsr" - Control and status register *
# "Zefencei" - Instruction-fetch fence
#
# This means that a CPU might look like `RV64IMAFDC`, which has a nice
# ring to it. Luckily the RISC-V team has defined the bare minimum of
# what can be considered a "general-purpose" ISA as RV32G/RV64G which
# contains the IMAFD, Zicsr, and Zifencei extensions. So you may see a
# CPU like `RV64IMAFDC` called `RV64GC` if it contains the expected
# instructions and the compressed extensions. This matters for us in the
# shellcoding process as we should attempt to stay as close to the G
# standard as much as possible as that might be all that can be expected
# for us to have.
#
# Chapter 25: RV32/64G Instruction Set Listings gives a wonderful layout
# and good reference for the types of instructions and a table
# containing the instructions in a good reference table.
#
# The RISC-V "green card" has a few pieces of outdated information, but
# is also a great reference that I used heavily:
#
# https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf
#
# In the instruction land it is important to note one additional thing,
# the assembler understands a set of pseudoinstructions.  The
# pseudoinstructions are linker understood instructions that are aliases
# for common functions, the table of these can be seen in Table 26.2
# with a translation of what the instructions are translated to. This
# can be rather confusing as certain instructions may generate their
# translated counterparts or not. An example is the `li`
# pseudo-instruction that may generate different code depending on data
# is being loaded. The confusing-ness is even more confusing based on
# the ISA specification specifically stating that "This chapter is a
# placeholder for an assembly programmer’s manual" which is not
# particularly helpful. 
#
# The second step to understanding this is to understand the calling
# convention in RISC-V and then what the implimentation actually looks
# like. Luckily the calling convention is pretty easy to find and has a
# very easy to understand table:
# https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf 
#
# This calling convention gives us a starting point and some hints about
# how things work after objdump'ing simple1.c, but for some more context
# it is better to probably go straight to the kernel and libc: 
# 
# https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/riscv/sysdep.h;h=5470ea3d2a6882ad34e5fc924517fd6fc98add2b;hb=HEAD
# https://github.com/torvalds/linux/tree/master/arch/riscv
# http://man7.org/linux/man-pages/man2/syscall.2.html#NOTES 
#
# Based on the documentation in syscall(2) and glibc - a7 will hold the
# exit syscall and a0 will be the initial first argument and will also
# hold the return value from the syscall after execution
#
# ecall is the replacement for scall that might be seen in earlier
# versions of the RISC-V ISA
#
# The last step is to discover what the actual syscall number is and for
# this if you are on the fedora image you can check
# /usr/include/asm-generic/unistd.h or
# https://github.com/torvalds/linux/blob/master/tools/include/uapi/asm-generic/unistd.h
#
# A quick grep for __NR_exit indicates that the system call is 93.
.section .text
.globl _start
_start:
# To set this up we need to load our exit value (7) into the first
# argument for the system call. Many syscall's are wrapped by libc and
# you should make sure to use the kernel versions of the calls and not
# what is expected from libc.
#
# The first part of this clears the a0 register using RV64G standard
# instructions. The second uses the `li` pseudoinstruction to load the
# systemcall number.
	xor a0,a0,a0	# Zero out the first argument (a0)
	addi a0,a0,0x7  # Add 7 to a0. addi dest,src,immediate
	li a7, 93	# 93 is the __NR_exit syscall
	ecall		# trigger system call
