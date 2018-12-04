/* +++++++++++++++
 * PRODUCER ....
 * */

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define BUF_LEN 512
#define FIFO "/tmp/it4.fifo"
#define QUIT 'q'

int main(int argc, char **argv) {
  char storage[BUF_LEN];

  int fd;
  int written=0;

  /* TEST for FIFO & create storage on demand */
  // umask(0);

  if (mkfifo(FIFO, 0666) < 0) {
    /* FIFO already exists - no error !! */
    if (errno == EEXIST)
      printf("FIFO %s already has been created.\n", (char *)FIFO);
    else {
      printf("Error in creating the fifo buffer <%s>, Error: <%s>", FIFO,
             strerror(errno));
      exit(EXIT_FAILURE);
    }
  }

  /*Producer writes to FIFO */
  fd = open(FIFO, O_WRONLY);
  if (fd == -1) {
    printf("Error occured in opening FIFO-Buffer, Error:<%s>\n", strerror(errno));
    unlink(FIFO);
    exit(EXIT_FAILURE);
  }
  while (storage[0] != QUIT) {
    printf("Enter your message for FIFO [\"q\" for exit] \n>");
    scanf("%s", storage);
    if (storage[0] != QUIT) {
      strcat(storage, "\n");
      written = write(fd, storage, strlen(storage) + 1);
      if (written < 0) {
         printf("Error occured in writing to stream, Error: <%s>: %s\n", strerror(errno));
         unlink(FIFO);
         close(fd);
         exit(EXIT_FAILURE);
      }
    }
  }
  close(fd);
  unlink(FIFO);
  return EXIT_SUCCESS;
}
