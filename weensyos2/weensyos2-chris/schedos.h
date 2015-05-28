#ifndef WEENSYOS_SCHEDOS_H
#define WEENSYOS_SCHEDOS_H
#include "types.h"

/*****************************************************************************
 * schedos.h
 *
 *   Constants and variables shared by SchedOS's kernel and applications.
 *
 *****************************************************************************/

// System call numbers.
// An application calls a system call by causing the specified interrupt.

#define INT_SYS_YIELD		48
#define INT_SYS_EXIT		49
#define INT_SYS_USER1		50
#define INT_SYS_USER2		51
#define INT_SYS_USER3		52


// The current screen cursor position (stored at memory location 0x198000).

extern uint16_t * volatile cursorpos;

// Exercise 6: use this lock to stop race condition
extern uint32_t lock;

// Extra credit 8: uncomment this macro to set the synchronization mechanism to the second implementation for Ex. 8
// comment out to use the solution for Ex. 6: a lock mechanism with atomic_swap()
// #define USE_SYSTEM_SYNC 1

#endif
