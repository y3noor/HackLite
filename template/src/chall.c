#include <stdio.h>
#include <unistd.h>
int main() {
   setvbuf(stdin, NULL, _IONBF, 0);
   setvbuf(stdout, NULL, _IONBF, 0);
   alarm(60);
   printf("Hello Hackers!");
   return 0;
}
