OBJ =\
       asm1.o\
       asm2.o
BIN =\
     simple1\
     simple2\
     simple3\
     asm1\
     asm2\
     asm3\
     sc1

BINPATH = bin

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
	rm -f $(BINPATH)/$(OBJ) $(BINPATH)/$(BIN)

shellcode:
	gcc -O0 -fpic src/sctester.c -o $(BINPATH)/sc1

.PHONY:
	all clean asm c
