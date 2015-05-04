// UCLA CS 111 Lab 1 command execution

#include "alloc.h"
#include "command.h"
#include "command-internals.h"

#include <error.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>

#define DEBUG 1

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
  if (c->input && c->u.subshell_command->input == NULL) {
    c->u.subshell_command->input = c->input;
  }
  if (c->output && c->u.subshell_command->output == NULL) {
    c->u.subshell_command->output = c->output;
  }
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
execute_sequence(command_t c, bool time_travel)
{
  execute_command(c->u.command[0], time_travel);
  execute_command(c->u.command[1],time_travel);
  c->status = c->u.command[1]->status;
}

void
execute_pipe(command_t c, bool time_travel)
{
  int fd[2];
  pipe(fd);
  pid_t first_pid = fork();
  if(first_pid == 0) {
    // left command (will write data to pipe)
    close(fd[0]);   // close unused read end
    dup2(fd[1], 1);
    execute_command(c->u.command[0], time_travel);
    close(fd[1]);
    _exit(c->u.command[0]->status);
  } else if (first_pid > 0) {
    int status;
    waitpid(-1, &status, 0);
    status = WEXITSTATUS(status);
    if (status != 0) {
      // something went wrong
      error(1, 0, "Invalid pipe command\n");
    }
    pid_t second_pid = fork();
    if (second_pid == 0) {
      // right command (waiting for data from pipe)
      close(fd[1]);   // close unused write end
      dup2(fd[0],0);
      execute_command(c->u.command[1], time_travel);
      close(fd[0]);
      _exit(c->u.command[1]->status);
    } else if (second_pid > 0) {
    	// close unnused pipe
      close(fd[0]);
      close(fd[1]);
      // parent wait for the two children
      waitpid(-1, &status, 0);
      c->status = WEXITSTATUS(status);
    }
  } 
}

void
execute_command (command_t c, bool time_travel)
{
	char cmd_type = ' ';
	switch(c->type) {
    case SIMPLE_COMMAND:
    	execute_simple(c);
    	cmd_type = 's';
    	break;
    case SUBSHELL_COMMAND:
    	execute_subshell(c, time_travel);
    	cmd_type = '(';
    	break;
    case AND_COMMAND:
    	execute_and(c, time_travel);
    	cmd_type = 'a';
    	break;
    case OR_COMMAND:
    	execute_or(c, time_travel);
    	cmd_type = 'o';
    	break;
    case SEQUENCE_COMMAND:
    	execute_sequence(c, time_travel);
    	cmd_type = ';';
    	break;
    case PIPE_COMMAND:
    	execute_pipe(c, time_travel);
    	cmd_type = '|';
    	break;
		default:
			return;
	}
	if (DEBUG) {
		printf("%c cmd - exit status: %d\n", cmd_type, c->status);
	}
}




/**
*  Time Travel
**/

list_node *depend_head;

void
store_dependency(list_node *list, char *word, bool write)
{
  if (write) {
    // write
    list->write_size++;
    if (list->write_list) {
      list->write_list = (char **)checked_realloc(list->write_list, list->write_size*sizeof(char*));
    } else {
      list->write_list = (char **)checked_malloc(list->write_size*sizeof(char*));
    }
    list->write_list[list->write_size-1] = word;
  } else {
    // read
    list->read_size++;
    if (list->read_list) {
      list->read_list = (char **)checked_realloc(list->read_list, list->read_size*sizeof(char*));
    } else {
      list->read_list = (char **)checked_malloc(list->read_size*sizeof(char*));
    }
    list->read_list[list->read_size-1] = word;
  }
}

void
process_dependencies(list_node *list, command_t command)
{
  if (command->input) {
    store_dependency(list, command->input, false);
  }
  if (command->output) {
    store_dependency(list, command->output, true);
  }

  if (command->type == SIMPLE_COMMAND) {
    if (command->u.word[0]) {
      int word_idx = 1;
      while (command->u.word[word_idx]) {
        store_dependency(list, command->u.word[word_idx], false);
      }
    }
  } else if (command->type == SUBSHELL_COMMAND) {
    process_dependencies(list, command->u.subshell_command);
  } else {
    // 2 subcommands
    process_dependencies(list, command->u.command[0]);
    process_dependencies(list, command->u.command[1]);
  }
}

graph_node *
process_command(command_t command)
{
  // new graph node
  graph_node *node = (graph_node *)checked_malloc(sizeof(graph_node));
  node->root = command;
  node->next = node->prev = NULL;
  node->pid = -1;
  node->before = NULL;

  // new list node
  list_node *list = (list_node *)checked_malloc(sizeof(list_node));
  list->node = node;
  list->write_list = list->read_list = NULL;
  list->write_size = list->read_size = 0;
  list->next = list->prev = NULL;

  process_dependencies(list, command);
  return node;
}


void
execute_graph(dependency_graph_t graph)
{
  printf("\n\n\n\n");
  print_dependencies(graph->no_dependencies);
}

