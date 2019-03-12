#include <stdio.h>
#include <string.h>

//const unsigned char code[] = "\x00";
#ifdef SC1
#include "sc1.h"
#elif SC2
#include "sc2.h"
#endif

int main(){
  printf("Shellcode Length:  %d\n", strlen(code));
  int (*func)();
  func = (int (*)()) code;
  (int)(*func)();
  printf("Did the process continue?\n");
  return 0;
}
