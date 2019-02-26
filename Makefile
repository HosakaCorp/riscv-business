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
     $(BINPATH)/sc1

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

clean:
	rm -f $(OBJ) $(BIN)

shellcode:
	gcc -O0 -fpic src/sctester.c -o $(BINPATH)/sc1

package: c asm shellcode
	tar cvzf shellcoding-riscv.tar.gz $(BINPATH)/*

.PHONY:
	all clean asm shellcode package c
