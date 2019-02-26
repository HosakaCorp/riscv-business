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
     shellcode

BINPATH = bin

all: c asm shellcode

c:
	gcc -O0 -pic simple1.c -o $(BINPATH)/simple1
	gcc -O0 -pic simple2.c -o $(BINPATH)/simple2
	gcc -O0 -pic simple3.c -o $(BINPATH)/simple3

asm:
	gcc -c asm1.s -o $(BINPATH)/asm1.s
	ld $(BINPATH)/asm1.o -o $(BINPATH)/asm1 
	gcc -c asm2.s -o $(BINPATH)/asm2.s
	ld $(BINPATH)/asm2.o -o $(BINPATH)/asm2 

clean:
	rm -f $(BINPATH)/$(OBJ) $(BINPATH)/$(BIN)
