#include <sys/socket.h>
int main() {
  int fd = 0 ;
  struct sockaddr s_a;
  connect(fd, (struct sockaddr *)&s_a, sizeof(s_a)) ;
}

