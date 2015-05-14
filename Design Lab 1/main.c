// UCLA CS 111 Lab 1 main program

#include <errno.h>
#include <error.h>
#include <getopt.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <readline/readline.h>
#include <readline/history.h>

#include "command.h"

static int
get_next_byte (char **stream)
{
  return *((*stream)++);
}

int
main ()
{
  // store input
  char* input, shell_prompt[128];
 
  // handle tabs
  rl_bind_key('\t', rl_complete);

  bool active = true;
  while (active) {
    // Create prompt string from user name and current working directory.
    snprintf(shell_prompt, sizeof(shell_prompt), "timetrash ? ");
    input = readline(shell_prompt);

    if (!input) {
      break;
    }

    add_history(input);

    char *cmd = input;
    command_stream_t command_stream = make_command_stream (get_next_byte, &cmd);

    command_t command;
    while ((command = read_command_stream (command_stream)))
    {
      execute_command (command, false);
    }

    free(input);
  }
  
  return 0;
}
