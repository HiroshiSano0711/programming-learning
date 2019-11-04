#include <stdio.h>
#include <stdlib.h>

#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

static char *read_file_contents() {
  FILE *fp;
  long file_size;
  int file_size_max = 10 * 1024 * 1024;
  struct stat stbuf;
  char *buffer;
  int fd;

  fd = open("main.txt", O_RDONLY);
  if (fd == -1)
      printf("cant open file : %s.\n", "main.txt");

  fp = fdopen(fd, "rb");
  if (fp == NULL)
    printf("cant open file : %s.\n", "main.txt");

  if (fstat(fd, &stbuf) == -1)
    printf("cant get file state : %s.\n", "main.txt");

  file_size = stbuf.st_size;

  if(file_size > file_size_max)
    printf("file too large");

  buffer = malloc(file_size);
  fread(buffer, 1, file_size, fp);

  if (fclose(fp) != 0)
    printf("cant close file : %s.\n", "main.txt");

  return buffer;
}

int main(int argc, char const *argv[]) {
  char *file_contents = read_file_contents();

  while(*file_contents){
    printf("%s", file_contents);
    file_contents++;
  }

  return 0;
}
