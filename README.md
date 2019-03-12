RISC-V 64LE Linux Shellcoding
=============================

This repository contains all the code used to create a minimal example
of creating shellcode for RISC-V 64LE. I attempted to do this as black-
box as possible using only the RISC-V documentation and source from gcc,
glibc, and the linux kernel. This was dual purpose to work on furthering
my understanding of hardware specifics, to learn to shellcode on a
lesser known/new ISA, and to attempt to get some payloads available even
before common adoption.

Repository Layout
-----------------
Inside of the `src/` directory there are simple C examples
(`simpleN.c`), assembly examples (`asmN.s`), and shellcode examples
(`scN.h`) that are included by `sctester.c` and executed using a GCC
trampoline.

The reading path is not one-to-one by the numbers, instead it should be
read in the following manner or as described in the coming blogpost:

| files | lesson |
| :----- | :------ |
|`asm1.s`, `asm2.s` | Learn about the basic calling conventions, linux specifics for system calls, data access |
| `asm3.s` | Port a program to not use the rodata section and learn about PIC |
| `asm4.s` | Graceful shell spawning in assembly |
| `sc1.h`, `asm5.s` | Learn about the pitfalls of shellcode and use a simple shellcode tester to check for null chars |
| `sc2.h`, `asm6.s` | Discover more pitfalls, solutions, and port the more advanced shell exec shellcode |
| `asm7.s` | Create a reverse shell in assembly |
| `asm8.s`, `sc3.h` | Porting the reverse shell to shellcode |

Additionally, it is extremely common for most of the implimentations of
RISC-V to contain the C compressed instruction extension. For that
reason I decided to add a few examples:

| files | lesson |
| :----- | :------ |
|`asm6c.s` | An example of some shellcode with compressed instructions and less xor |

Usage / Building
----------------
It is expected that you have a VM to test with, the instructions for
running will be here. Once you have the VM the code can either be
compiled from the directly from the root of the repository with a simple
`make` in the root of the directory. This expect you to have `gcc(1)` and
`as(1)` for assembly.

Additionally the realease page should have a copy of the bin directory 
after a successful compilation.

Supporting/Helpful Documents
---------------------------- 
- [RISC-V Green Card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)
- [RISC-V User-Level ISA](https://content.riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf)
- [Linux RISC-V Kernel](https://github.com/torvalds/linux/tree/master/arch/riscv)
- [Linux Architecture Specific syscall(2) Info](http://man7.org/linux/man-pages/man2/syscall.2.html#NOTES)
- [Fedora RISC-V Images](https://fedoraproject.org/wiki/Architectures/RISC-V/Installing)
