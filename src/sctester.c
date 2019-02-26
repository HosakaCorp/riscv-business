#include<stdio.h>
#include<string.h>

unsigned char code[] = "{SHELLCODEGOESHERE}";

int main(){
  printf("Shellcode Length:  %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
