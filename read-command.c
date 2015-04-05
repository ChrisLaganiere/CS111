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

token_t
make_tokens (char *char_buffer)
{
  // don't continue if char_buffer is empty
  if (char_buffer[0] == '\0') {
    return NULL;
  }

  token_t head = NULL;
  token_t current = NULL;

  int buffer_index = 0;
  int line = 0;
  char a;
  char b;
  int word_length;
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
    if (type == UNKNOWN_TOKEN) {
      word_length = 0;
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

void
list_tokens (token_t tokens)
{
  printf("Available tokens:\n\n0: AND_TOKEN\n1: SEQUENCE_TOKEN\n2: OR_TOKEN\n3: PIPE_TOKEN\n4: SIMPLE_TOKEN\n5: OPEN_PARENS_TOKEN\n6: CLOSE_PARENS_TOKEN\n7: INPUT_TOKEN\n8: OUTPUT_TOKEN\n9: NEWLINE_TOKEN\n10: COMMENT_TOKEN\n11: UNKNOWN_TOKEN\n\n");
  printf("Parsed tokens:\n");
  while (tokens) {
    printf("%d", tokens->type);
    if (tokens->type == SIMPLE_TOKEN)
      printf(" %s", tokens->word);
    printf("\n");
    tokens = tokens->next;
  }
}

command_stream_t
make_command_stream (int (*get_next_byte) (void *),
         void *get_next_byte_argument)
{
  char *char_buffer = read_chars(get_next_byte, get_next_byte_argument);
  token *tokens = make_tokens(char_buffer);

  if (tokens == NULL) {
    return NULL;
  } else {
    list_tokens(tokens);
  }

  error (1, 0, "command making not yet implemented");
  return 0;
}

command_t
read_command_stream (command_stream_t s)
{
  
  /* FIXME: Replace this with your implementation.  You may need to
     add auxiliary functions and otherwise modify the source code.
     You can also use external functions defined in the GNU C Library.  */
  error (1, 0, "command reading not yet implemented");

  return 0;
}
