#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

char *sysrootdir = "";

int main(int argc, char *argv[]) {
  sysrootdir = getenv("CLFS");
  if (!sysrootdir)
    sysrootdir="";

  int stdout_pipe[2];
  pipe(stdout_pipe);

  pid_t pid = fork();

  if (pid == 0) {
    /* Redirect stdout to our pipe */
    close(1);
    dup(stdout_pipe[1]);
    close(stdout_pipe[0]);
    close(stdout_pipe[1]);

    char *name = strdup(argv[0]);
    strcat(name, ".sysroot");

    execvp(name, argv);

    free(name);

    exit(0);
  } else {
    /* Close stdout for write */
    close(stdout_pipe[1]);

    /* redirect our stdout pipe from the child to our stdin */
    close(0);
    dup(stdout_pipe[0]);
    close(stdout_pipe[0]);

    char c, lc;
    char *d = malloc(1);
    int d_len = 0;

    while ((c = fgetc(stdin)) != EOF) {
      d_len++;
      d = realloc(d, d_len + 1);
      *(d + d_len - 1) = c;
      *(d + d_len) = '\0';

      if ((lc == '-')&&((c == 'L')||(c == 'I'))) {
        d_len = d_len + strlen(sysrootdir);
        d = realloc(d, d_len + 1);
        strcat(d, sysrootdir);
      }

      lc = c;
    }

    printf ("%s", d);
    free(d);

    exit(0);
  }

  return 0;
}
