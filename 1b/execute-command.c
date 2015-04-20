// UCLA CS 111 Lab 1 command execution

#include "command.h"
#include "command-internals.h"

#include <error.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */

int
command_status (command_t c)
{
  return c->status;
}

/*
*  Set up file descriptors duplicating std_in or std_out as appropriate for a given command c
*/
void
handle_redirection(command_t c)
{
	// handle < input
	if (c->input) {
		int in_fd = open(c->input, O_RDONLY, 0644);
		if (in_fd < 0) {
			return;
		}
		dup2(in_fd, 0);
		close(in_fd);
	}

	// handle > output
	if (c->output) {
		int out_fd = open(c->output, O_CREAT | O_TRUNC | O_WRONLY, 0644);
		if (out_fd < 0) {
			return;
		}
		dup2(out_fd, 1);
		close(out_fd);
	}
}

void
execute_simple(command_t c)
{
	pid_t p = fork();
	if (p == 0) {
		// child process
		handle_redirection(c);
		execvp(c->u.word[0], c->u.word);
		// if execvp returns, the command was invalid
    error(1, 0, "Invalid simple command\n");
	} else if (p > 0) {
		// parent process
		int status;
		waitpid(p, &status, 0);
		c->status = WEXITSTATUS(status);
	} else {
		// something went wrong with fork()
    error(1, 0, "Error forking process\n");
	}
}

void
execute_subshell(command_t c, bool time_travel)
{
	// TODO: figure out redirection for cases like '(cat a.txt) > b.txt'. This doesn't seem to work:
	// handle_redirection(c);
	execute_command(c->u.subshell_command, time_travel);
	c->status = c->u.subshell_command->status;
}

void
execute_and(command_t c, bool time_travel)
{
	execute_command(c->u.command[0], time_travel);
	if (c->u.command[0]->status == 0) {
		execute_command(c->u.command[1], time_travel);
		c->status = c->u.command[1]->status;
	} else {
		c->status = c->u.command[0]->status;
	}
}

void
execute_or(command_t c, bool time_travel)
{
	execute_command(c->u.command[0], time_travel);
	if (c->u.command[0]->status != 0) {
		execute_command(c->u.command[1], time_travel);
		c->status = c->u.command[1]->status;
	} else {
		c->status = c->u.command[0]->status;
	}
}

void
execute_command (command_t c, bool time_travel)
{
	switch(c->type) {
    case SIMPLE_COMMAND:
    	execute_simple(c);
    	break;
    case SUBSHELL_COMMAND:
    	execute_subshell(c, time_travel);
    	break;
    case AND_COMMAND:
    	execute_and(c, time_travel);
    	break;
    case OR_COMMAND:
    	execute_or(c, time_travel);
    	break;
    case SEQUENCE_COMMAND:
    	// TODO: handle sequence commands
    	break;
    case PIPE_COMMAND:
    	// TODO: handle pipe commands
    	break;
		default:
			return;
	}

  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
  // error(1, 0, "Could not execute command");
}
