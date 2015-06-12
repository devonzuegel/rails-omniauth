SIGCALL & System Call Traces
static pid_t pid = 0;
static void handleSIGCALL(int sig) {
  while (true) {
    const char *name = getsyscall(pid);
    if (name == NULL) return;
    printf("%s\n", name);
  }
}

int main(int argc, char *argv[]) {
  signal(SIGCALL, handleSIGCALL);
  pid = fork();
  if (pid == 0) {
    int f = open("/dev/null", O_WRONLY);
    dup2(f, STDOUT_FILENO);
    dup2(f, STDERR_FILENO);
    close(f);
    execvp(argv[1], argv + 1);
  }

  int status;
  waitpid(pid, &status, 0);
  return WEXITSTATUS(status);
} 