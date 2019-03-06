#include <stdio.h>
#include <string.h>

#ifdef SC1
#include "sc1.h"
#elif SC2
#include "sc2.h"
#endif

int main(){
  printf("Shellcode Length:  %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
