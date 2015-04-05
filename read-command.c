// UCLA CS 111 Lab 1 command reading

#include "alloc.h"
#include "command.h"
#include "command-internals.h"

#include <error.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

/* FIXME: You may need to add #include directives, macro definitions,
   static function definitions, etc.  */

/* FIXME: Define the type 'struct command_stream' here.  This should
   complete the incomplete type declaration in command.h.  */

typedef struct command_node
{
  command_t command;
  struct command_node *next;
  struct command_node *prev;
} command_node;

struct command_stream
{
  struct command_node *head;
  struct command_node *tail;
  struct command_node *cursor; // initialize to head
};

// char * read_chars(int (*get_next_byte) (void *), void *get_next_byte_argument);
// int simple_char (char a);
// token_t make_tokens (char *char_buffer);
// void list_tokens (token_t tokens);
// void check_token_syntax (token_t tokens);

// MARK: read input characters

/*
Read input characters using GET_NEXT_BYTE and GET_NEXT_BYTE_ARGUMENT, and return in a c string
*/
char *
read_chars(int (*get_next_byte) (void *),
         void *get_next_byte_argument)
{
  size_t buffer_index = 0;
  size_t buffer_size = 1024;
  char *char_buffer = checked_malloc(buffer_size);
  char next_char;

  // get all characters
  while ((next_char = get_next_byte(get_next_byte_argument)) && next_char != EOF) {
    char_buffer[buffer_index] = next_char;
    buffer_index++;

    if (buffer_index + 1 >= buffer_size) {
      char_buffer = checked_grow_alloc(char_buffer, &buffer_size);
    }
  }
  char_buffer[buffer_index] = '\0';

  return char_buffer;
}

// MARK: identify tokens

/*
Return 1 for a valid char of a simple token, or 0 otherwise
*/
int
simple_char (char a)
{
  switch (a) {
    case '!':
    case '%':
    case '+':
    case ',':
    case '-':
    case '.':
    case '/':
    case ':':
    case '@':
    case '^':
    case '_':
      return 1;
    default:
       break;
  }

  return isalnum(a);
}

/*
Identify tokens in c string and return a linked list of token structs representing CHAR_BUFFER
*/
token_t
make_tokens (char *char_buffer)
{
  token_t head = NULL;
  token_t current = NULL;

  int buffer_index = 0;
  int line = 1;
  char a;
  char b;
  token_type_t type;

  // process tokens
  while (char_buffer[buffer_index] != '\0') {
    // get token characters
    a = char_buffer[buffer_index];
    b = char_buffer[buffer_index + 1];

    // identify token
    switch(a) {
      case '&':
        if (b == '&') {
          type = AND_TOKEN;
          // skip next character
          buffer_index++;
        } else {
          type = UNKNOWN_TOKEN;
        }
        break;
      case ';':
        type = SEQUENCE_TOKEN;
        break;
      case '|':
        if (b == '|') {
          type = OR_TOKEN;
          // skip next character
          buffer_index++;
        } else {
          type = PIPE_TOKEN;
        }
        break;
      case '(':
        type = OPEN_PARENS_TOKEN;
        break;
      case ')':
        type = CLOSE_PARENS_TOKEN;
        break;
      case '<':
        type = INPUT_TOKEN;
        break;
      case '>':
        type = OUTPUT_TOKEN;
        break;
      case '\n':
        type = NEWLINE_TOKEN;
        line++;
        break;
      case '#':
        // check if comment is valid
        if (buffer_index == 0 || !simple_char(char_buffer[buffer_index - 1])) {
          while ((b = char_buffer[buffer_index + 1]) && b != '\n' && b != '\0') {
            buffer_index++;
          }
          type = COMMENT_TOKEN;
        } else {
          // invalid comment
          fprintf(stderr, "%i: comment must not be preceded by an ordinary token", line);
          exit(1);
        }
        break;
      case ' ':
      case '\t':
        buffer_index++;
        continue;
      default:
        type = UNKNOWN_TOKEN;
        break;
    }

    // handle simple word
    int word_length = 0;
    if (type == UNKNOWN_TOKEN) {
      while (simple_char(char_buffer[buffer_index + word_length])) {
        word_length++;
      }
      if (word_length > 0) {
        type = SIMPLE_TOKEN;
      }
    }

    // reject anything that couldn't be identified
    if (type == UNKNOWN_TOKEN) {
      fprintf(stderr, "%i: invalid token: %c", line, a);
      exit(1);
    }

    // build token
    token_t new_token = (token *)checked_malloc(sizeof(token));
    new_token->next = new_token->prev = NULL;
    new_token->word = NULL;
    new_token->type = type;
    if (type == SIMPLE_TOKEN) {
      new_token->word = (char *)checked_malloc(word_length*sizeof(char) + 1);
      int l;
      for (l = 0; l < word_length; l++) {
        new_token->word[l] = char_buffer[buffer_index + l];
      }
      new_token->word[word_length] = '\0';

      // don't reprocess word characters
      buffer_index += word_length-1;
    }
    if (head == NULL) {
      head = current = new_token;
    } else {
      current->next = new_token;
      new_token->prev = current;
      current = new_token;
    }

    buffer_index++;
  }

  return head;
}

/*
Output tokens in TOKENS, for debugging
*/
void
list_tokens (token_t tokens)
{
  printf("Available tokens:\n0: AND_TOKEN\n1: SEQUENCE_TOKEN\n2: OR_TOKEN\n3: PIPE_TOKEN\n4: SIMPLE_TOKEN\n5: OPEN_PARENS_TOKEN\n6: CLOSE_PARENS_TOKEN\n7: INPUT_TOKEN\n8: OUTPUT_TOKEN\n9: NEWLINE_TOKEN\n10: COMMENT_TOKEN\n11: UNKNOWN_TOKEN\n\n");
  printf("Parsed tokens:\n");
  while (tokens) {
    printf("%d", tokens->type);
    if (tokens->type == SIMPLE_TOKEN) {
      printf(" %s", tokens->word);
    }
    printf("\n");
    tokens = tokens->next;
  }
}

// MARK: check token syntax

/*
Check for some syntax errors in a linked list of token structs TOKENS, exiting with an error if one is found
*/
void
check_token_syntax (token_t tokens)
{
  int line = 1;
  int open_parens = 0;
  int left_cmd = 0;
  int needs_right_cmd = 0;

  while (tokens) {
    switch (tokens->type) {
      case AND_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: '&&' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        needs_right_cmd = 1;
        break;
      case SEQUENCE_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: ';' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        break;
      case OR_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: '||' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        needs_right_cmd = 1;
        break;
      case PIPE_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: '|' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        needs_right_cmd = 1;
        break;
      case SIMPLE_TOKEN:
        left_cmd = 1;
        needs_right_cmd = 0;
        break;
      case OPEN_PARENS_TOKEN:
        open_parens++;
        left_cmd = 0;
        needs_right_cmd = 0;
        break;
      case CLOSE_PARENS_TOKEN:
        open_parens--;
        left_cmd = 1;
        break;
      case INPUT_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: '<' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        break;
      case OUTPUT_TOKEN:
        if (!left_cmd) {
          fprintf(stderr, "%i: '>' must come after a valid command", line);
          exit(1);
        }
        left_cmd = 0;
        break;
      case NEWLINE_TOKEN:
        line++;
        left_cmd = 0;
        break;
      default:
        break;
    }

    if (open_parens < 0) {
      fprintf(stderr, "%i: too many closing parentheses", line);
      exit(1);
    }

    tokens = tokens->next;
  }

  if (open_parens != 0) {
    fprintf(stderr, "%i: not enough closing parentheses", line);
    exit(1);
  }
  if (needs_right_cmd) {
    fprintf(stderr, "%i: missing right-side command", line);
    exit(1);
  }
}

// MARK: identify commands

command_t
pop(token_t tokens)
{
  token_t top = tokens;
  tokens = tokens->next;
  return top;
}

command_stream_t
identify_commands(token_t tokens)
{

}

// MARK: make_command_stream implementation

command_stream_t
make_command_stream (int (*get_next_byte) (void *),
         void *get_next_byte_argument)
{
  char *char_buffer = read_chars(get_next_byte, get_next_byte_argument);
  token *tokens = make_tokens(char_buffer);

  if (!tokens) {
    return NULL;
  }
  
  list_tokens(tokens);
  check_token_syntax(tokens);

  error (1, 0, "command making not yet implemented");
  return 0;
}

// MARK: read_command_stream implementation

command_t
read_command_stream (command_stream_t s)
{
  
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
  error (1, 0, "command reading not yet implemented");

  return 0;
}
