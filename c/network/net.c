#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>

int main() {
 int sock;

 sock = socket(AF_INET, SOCK_STREAM, 0);
 if (sock < 0) {
	printf("socket failed\n");
	return 1;
  }
  printf("socket = %d\n", sock);

 return 0;
}