BINPATH = bin

OBJ =\
       $(BINPATH)/asm1.o\
       $(BINPATH)/asm2.o
BIN =\
     $(BINPATH)/simple1\
     $(BINPATH)/simple2\
     $(BINPATH)/simple3\
     $(BINPATH)/asm1\
     $(BINPATH)/asm2\
     $(BINPATH)/asm3\
     $(BINPATH)/asm4\
     $(BINPATH)/asm5\
     $(BINPATH)/asm6\
     $(BINPATH)/sc1\
     $(BINPATH)/sc2

JNK =\
     shellcoding-riscv.tar.gz

all: c asm shellcode

c:
	gcc -O0 -fpic src/simple1.c -o $(BINPATH)/simple1
	gcc -O0 -fpic src/simple2.c -o $(BINPATH)/simple2
	gcc -O0 -fpic src/simple3.c -o $(BINPATH)/simple3

asm:
	gcc -c src/asm1.s -o $(BINPATH)/asm1.o
	ld $(BINPATH)/asm1.o -o $(BINPATH)/asm1 
	gcc -c src/asm2.s -o $(BINPATH)/asm2.o
	ld $(BINPATH)/asm2.o -o $(BINPATH)/asm2 
	gcc -c src/asm3.s -o $(BINPATH)/asm3.o
	ld $(BINPATH)/asm3.o -o $(BINPATH)/asm3 
	gcc -c src/asm4.s -o $(BINPATH)/asm4.o
	ld $(BINPATH)/asm4.o -o $(BINPATH)/asm4 
	gcc -c src/asm5.s -o $(BINPATH)/asm5.o
	ld $(BINPATH)/asm5.o -o $(BINPATH)/asm5 
	gcc -c src/asm6.s -o $(BINPATH)/asm6.o
	ld $(BINPATH)/asm6.o -o $(BINPATH)/asm6 

clean:
	rm -f $(OBJ) $(BIN) $(JNK)

shellcode:
	gcc -O0 -DSC1 -fno-stack-protector -z execstack -no-pie src/sctester.c -o $(BINPATH)/sc1
	gcc -O0 -DSC2 -fno-stack-protector -z execstack -no-pie src/sctester.c -o $(BINPATH)/sc2

package: c asm shellcode
	tar cvzf shellcoding-riscv.tar.gz $(BINPATH)/*

.PHONY:
	all clean asm shellcode package c
