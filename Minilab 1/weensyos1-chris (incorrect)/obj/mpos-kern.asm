
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 24 02 00 00       	call   10023d <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 54 9f 10 00       	mov    0x109f54,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 f4 91 10 00 01 	cmpl   $0x1,0x1091f4(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 ac 91 10 00       	add    $0x1091ac,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 a5 03 00 00       	call   100460 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d 54 9f 10 00    	mov    0x109f54,%ebx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 04             	cmp    $0x4,%eax
  1000e1:	0f 87 54 01 00 00    	ja     10023b <interrupt+0x180>
  1000e7:	ff 24 85 18 0a 10 00 	jmp    *0x100a18(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000f0:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000f3:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  1000f6:	53                   	push   %ebx
  1000f7:	e9 9e 00 00 00       	jmp    10019a <interrupt+0xdf>
  1000fc:	b8 48 92 10 00       	mov    $0x109248,%eax
  100101:	bd 01 00 00 00       	mov    $0x1,%ebp
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
  process_t *new_proc;
  pid_t p_pid = 1;
  while (p_pid < NPROCS) {
    if (proc_array[p_pid].p_state == P_EMPTY) {
  100106:	83 38 00             	cmpl   $0x0,(%eax)
  100109:	75 07                	jne    100112 <interrupt+0x57>
    }
    p_pid++;
  }
  
  // check if found
  if (p_pid >= NPROCS) {
  10010b:	83 fd 0f             	cmp    $0xf,%ebp
  10010e:	7f 7b                	jg     10018b <interrupt+0xd0>
  100110:	eb 0b                	jmp    10011d <interrupt+0x62>
  while (p_pid < NPROCS) {
    if (proc_array[p_pid].p_state == P_EMPTY) {
      new_proc = &proc_array[p_pid];
      break;
    }
    p_pid++;
  100112:	45                   	inc    %ebp
  100113:	83 c0 54             	add    $0x54,%eax
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
  process_t *new_proc;
  pid_t p_pid = 1;
  while (p_pid < NPROCS) {
  100116:	83 fd 10             	cmp    $0x10,%ebp
  100119:	75 eb                	jne    100106 <interrupt+0x4b>
  10011b:	eb 6e                	jmp    10018b <interrupt+0xd0>
    if (proc_array[p_pid].p_state == P_EMPTY) {
      new_proc = &proc_array[p_pid];
  10011d:	6b c5 54             	imul   $0x54,%ebp,%eax
  // check if found
  if (p_pid >= NPROCS) {
    return -1;
  }
  
  new_proc->p_registers = parent->p_registers;
  100120:	b9 11 00 00 00       	mov    $0x11,%ecx
  100125:	8d 73 04             	lea    0x4(%ebx),%esi
	// Finally, return the child's process ID to the parent.
  process_t *new_proc;
  pid_t p_pid = 1;
  while (p_pid < NPROCS) {
    if (proc_array[p_pid].p_state == P_EMPTY) {
      new_proc = &proc_array[p_pid];
  100128:	89 c2                	mov    %eax,%edx
  10012a:	81 c2 ac 91 10 00    	add    $0x1091ac,%edx
  100130:	89 44 24 0c          	mov    %eax,0xc(%esp)
  // check if found
  if (p_pid >= NPROCS) {
    return -1;
  }
  
  new_proc->p_registers = parent->p_registers;
  100134:	8d 7a 04             	lea    0x4(%edx),%edi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
  100137:	8b 03                	mov    (%ebx),%eax
  // check if found
  if (p_pid >= NPROCS) {
    return -1;
  }
  
  new_proc->p_registers = parent->p_registers;
  100139:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  10013b:	8b 7c 24 0c          	mov    0xc(%esp),%edi
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((char *)dest_stack_bottom, (char *)src_stack_bottom, (src_stack_top - src_stack_bottom));
  10013f:	83 ec 04             	sub    $0x4,%esp
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
  100142:	8b 4b 40             	mov    0x40(%ebx),%ecx
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
  100145:	83 c0 0a             	add    $0xa,%eax
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  100148:	8b b7 ac 91 10 00    	mov    0x1091ac(%edi),%esi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
  10014e:	c1 e0 12             	shl    $0x12,%eax
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  100151:	c1 e6 12             	shl    $0x12,%esi
  100154:	8d b4 0e 00 00 28 00 	lea    0x280000(%esi,%ecx,1),%esi
  10015b:	29 c6                	sub    %eax,%esi
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((char *)dest_stack_bottom, (char *)src_stack_bottom, (src_stack_top - src_stack_bottom));
  10015d:	29 c8                	sub    %ecx,%eax
  10015f:	50                   	push   %eax
  100160:	51                   	push   %ecx
  100161:	56                   	push   %esi
  100162:	89 54 24 18          	mov    %edx,0x18(%esp)
  100166:	e8 cd 03 00 00       	call   100538 <memcpy>
	dest->p_registers.reg_esp = dest_stack_bottom;
  10016b:	8b 54 24 18          	mov    0x18(%esp),%edx
  
  new_proc->p_registers = parent->p_registers;
  copy_stack(new_proc, parent);
  new_proc->p_state = P_RUNNABLE;
  new_proc->p_registers.reg_eax = 0;
  new_proc->p_pid = p_pid;
  10016f:	83 c4 10             	add    $0x10,%esp
  100172:	89 af ac 91 10 00    	mov    %ebp,0x1091ac(%edi)
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp
	memcpy((char *)dest_stack_bottom, (char *)src_stack_bottom, (src_stack_top - src_stack_bottom));
	dest->p_registers.reg_esp = dest_stack_bottom;
  100178:	89 72 40             	mov    %esi,0x40(%edx)
    return -1;
  }
  
  new_proc->p_registers = parent->p_registers;
  copy_stack(new_proc, parent);
  new_proc->p_state = P_RUNNABLE;
  10017b:	c7 42 48 01 00 00 00 	movl   $0x1,0x48(%edx)
  new_proc->p_registers.reg_eax = 0;
  100182:	c7 42 20 00 00 00 00 	movl   $0x0,0x20(%edx)
  100189:	eb 03                	jmp    10018e <interrupt+0xd3>
  new_proc->p_pid = p_pid;
  10018b:	83 cd ff             	or     $0xffffffff,%ebp
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10018e:	89 6b 20             	mov    %ebp,0x20(%ebx)
		run(current);
  100191:	83 ec 0c             	sub    $0xc,%esp
  100194:	ff 35 54 9f 10 00    	pushl  0x109f54
  10019a:	e8 c1 02 00 00       	call   100460 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  10019f:	e8 e8 fe ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  1001a4:	a1 54 9f 10 00       	mov    0x109f54,%eax
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->blocked_proc > 0) {
  1001a9:	8b 50 50             	mov    0x50(%eax),%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
		current->p_exit_status = current->p_registers.reg_eax;
  1001ac:	8b 48 20             	mov    0x20(%eax),%ecx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  1001af:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->blocked_proc > 0) {
  1001b6:	85 d2                	test   %edx,%edx
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
		current->p_exit_status = current->p_registers.reg_eax;
  1001b8:	89 48 4c             	mov    %ecx,0x4c(%eax)
		if (current->blocked_proc > 0) {
  1001bb:	7e 21                	jle    1001de <interrupt+0x123>
		  proc_array[current->blocked_proc].p_state = P_RUNNABLE;
  1001bd:	6b d2 54             	imul   $0x54,%edx,%edx
		  proc_array[current->blocked_proc].p_registers.reg_eax = current->p_exit_status;
		  current->blocked_proc = -1;
  1001c0:	c7 40 50 ff ff ff ff 	movl   $0xffffffff,0x50(%eax)
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
		current->p_exit_status = current->p_registers.reg_eax;
		if (current->blocked_proc > 0) {
		  proc_array[current->blocked_proc].p_state = P_RUNNABLE;
  1001c7:	c7 82 f4 91 10 00 01 	movl   $0x1,0x1091f4(%edx)
  1001ce:	00 00 00 
		  proc_array[current->blocked_proc].p_registers.reg_eax = current->p_exit_status;
  1001d1:	89 8a cc 91 10 00    	mov    %ecx,0x1091cc(%edx)
		  current->blocked_proc = -1;
		  current->p_state = P_EMPTY;
  1001d7:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		}
		schedule();
  1001de:	e8 a9 fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001e3:	a1 54 9f 10 00       	mov    0x109f54,%eax
  1001e8:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001eb:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001ee:	83 f9 0e             	cmp    $0xe,%ecx
  1001f1:	77 16                	ja     100209 <interrupt+0x14e>
		    || proc_array[p].p_state == P_EMPTY)
  1001f3:	8b 08                	mov    (%eax),%ecx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001f5:	39 ca                	cmp    %ecx,%edx
  1001f7:	74 10                	je     100209 <interrupt+0x14e>
		    || proc_array[p].p_state == P_EMPTY)
  1001f9:	6b d2 54             	imul   $0x54,%edx,%edx
  1001fc:	8d 9a b4 91 10 00    	lea    0x1091b4(%edx),%ebx
  100202:	8b 73 40             	mov    0x40(%ebx),%esi
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100205:	85 f6                	test   %esi,%esi
  100207:	75 09                	jne    100212 <interrupt+0x157>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  100209:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100210:	eb 24                	jmp    100236 <interrupt+0x17b>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE) {
  100212:	83 fe 03             	cmp    $0x3,%esi
  100215:	75 12                	jne    100229 <interrupt+0x16e>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  100217:	8b 92 f8 91 10 00    	mov    0x1091f8(%edx),%edx
		        proc_array[p].p_state = P_EMPTY;
  10021d:	c7 43 40 00 00 00 00 	movl   $0x0,0x40(%ebx)
		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE) {
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  100224:	89 50 20             	mov    %edx,0x20(%eax)
  100227:	eb 0d                	jmp    100236 <interrupt+0x17b>
		        proc_array[p].p_state = P_EMPTY;
		}
		else {
		        proc_array[p].blocked_proc = current->p_pid;
  100229:	89 8a fc 91 10 00    	mov    %ecx,0x1091fc(%edx)
			current->p_state = P_BLOCKED;
  10022f:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
		}
		schedule();
  100236:	e8 51 fe ff ff       	call   10008c <schedule>
  10023b:	eb fe                	jmp    10023b <interrupt+0x180>

0010023d <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10023d:	53                   	push   %ebx
  10023e:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100241:	68 40 05 00 00       	push   $0x540
  100246:	6a 00                	push   $0x0
  100248:	68 ac 91 10 00       	push   $0x1091ac
  10024d:	e8 4a 03 00 00       	call   10059c <memset>
  100252:	b8 ac 91 10 00       	mov    $0x1091ac,%eax
  100257:	31 d2                	xor    %edx,%edx
  100259:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10025c:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10025e:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10025f:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].blocked_proc = -1;
  100266:	c7 40 50 ff ff ff ff 	movl   $0xffffffff,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10026d:	83 c0 54             	add    $0x54,%eax
  100270:	83 fa 10             	cmp    $0x10,%edx
  100273:	75 e7                	jne    10025c <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].blocked_proc = -1;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100275:	c7 05 54 9f 10 00 00 	movl   $0x109200,0x109f54
  10027c:	92 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  10027f:	e8 74 00 00 00       	call   1002f8 <segments_init>
	special_registers_init(current);
  100284:	83 ec 0c             	sub    $0xc,%esp
  100287:	ff 35 54 9f 10 00    	pushl  0x109f54
  10028d:	e8 e5 01 00 00       	call   100477 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100292:	e8 30 01 00 00       	call   1003c7 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100297:	83 c4 0c             	add    $0xc,%esp
  10029a:	68 2c 0a 10 00       	push   $0x100a2c
  10029f:	68 00 07 00 00       	push   $0x700
  1002a4:	ff 35 00 00 06 00    	pushl  0x60000
  1002aa:	e8 4f 07 00 00       	call   1009fe <console_printf>
  1002af:	83 c4 10             	add    $0x10,%esp
  1002b2:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1002b7:	e8 4e 01 00 00       	call   10040a <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1002bc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1002bf:	83 fb 01             	cmp    $0x1,%ebx
  1002c2:	77 f3                	ja     1002b7 <start+0x7a>
	console_clear();
  1002c4:	e8 fe 00 00 00       	call   1003c7 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1002c9:	50                   	push   %eax
  1002ca:	50                   	push   %eax
  1002cb:	a1 54 9f 10 00       	mov    0x109f54,%eax
  1002d0:	83 c0 34             	add    $0x34,%eax
  1002d3:	50                   	push   %eax
  1002d4:	53                   	push   %ebx
  1002d5:	e8 d2 01 00 00       	call   1004ac <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1002da:	a1 54 9f 10 00       	mov    0x109f54,%eax
  1002df:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1002e6:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  1002ed:	89 04 24             	mov    %eax,(%esp)
  1002f0:	e8 6b 01 00 00       	call   100460 <run>
  1002f5:	90                   	nop
  1002f6:	90                   	nop
  1002f7:	90                   	nop

001002f8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002f8:	b8 ec 96 10 00       	mov    $0x1096ec,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002fd:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100302:	89 c2                	mov    %eax,%edx
  100304:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100307:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100308:	bb 56 00 10 00       	mov    $0x100056,%ebx
  10030d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100310:	66 a3 ca 1a 10 00    	mov    %ax,0x101aca
  100316:	c1 e8 18             	shr    $0x18,%eax
  100319:	88 15 cc 1a 10 00    	mov    %dl,0x101acc
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10031f:	ba 54 97 10 00       	mov    $0x109754,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100324:	a2 cf 1a 10 00       	mov    %al,0x101acf
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100329:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10032b:	66 c7 05 c8 1a 10 00 	movw   $0x68,0x101ac8
  100332:	68 00 
  100334:	c6 05 ce 1a 10 00 40 	movb   $0x40,0x101ace
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10033b:	c6 05 cd 1a 10 00 89 	movb   $0x89,0x101acd

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100342:	c7 05 f0 96 10 00 00 	movl   $0x80000,0x1096f0
  100349:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10034c:	66 c7 05 f4 96 10 00 	movw   $0x10,0x1096f4
  100353:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100355:	66 89 0c c5 54 97 10 	mov    %cx,0x109754(,%eax,8)
  10035c:	00 
  10035d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100364:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100369:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10036e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100373:	40                   	inc    %eax
  100374:	3d 00 01 00 00       	cmp    $0x100,%eax
  100379:	75 da                	jne    100355 <segments_init+0x5d>
  10037b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10037f:	ba 54 97 10 00       	mov    $0x109754,%edx
  100384:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  10038b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100392:	66 89 0c c5 54 97 10 	mov    %cx,0x109754(,%eax,8)
  100399:	00 
  10039a:	c1 e9 10             	shr    $0x10,%ecx
  10039d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003a2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003a7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  1003ac:	40                   	inc    %eax
  1003ad:	83 f8 3a             	cmp    $0x3a,%eax
  1003b0:	75 d2                	jne    100384 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003b2:	b0 28                	mov    $0x28,%al
  1003b4:	0f 01 15 90 1a 10 00 	lgdtl  0x101a90
  1003bb:	0f 00 d8             	ltr    %ax
  1003be:	0f 01 1d 98 1a 10 00 	lidtl  0x101a98
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003c5:	5b                   	pop    %ebx
  1003c6:	c3                   	ret    

001003c7 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003c7:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003c8:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003ca:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003cb:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1003d2:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1003d5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1003dc:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1003df:	40                   	inc    %eax
  1003e0:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1003e5:	75 ee                	jne    1003d5 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003e7:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003ec:	b0 0e                	mov    $0xe,%al
  1003ee:	89 f2                	mov    %esi,%edx
  1003f0:	ee                   	out    %al,(%dx)
  1003f1:	31 c9                	xor    %ecx,%ecx
  1003f3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1003f8:	88 c8                	mov    %cl,%al
  1003fa:	89 da                	mov    %ebx,%edx
  1003fc:	ee                   	out    %al,(%dx)
  1003fd:	b0 0f                	mov    $0xf,%al
  1003ff:	89 f2                	mov    %esi,%edx
  100401:	ee                   	out    %al,(%dx)
  100402:	88 c8                	mov    %cl,%al
  100404:	89 da                	mov    %ebx,%edx
  100406:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100407:	5b                   	pop    %ebx
  100408:	5e                   	pop    %esi
  100409:	c3                   	ret    

0010040a <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10040a:	ba 64 00 00 00       	mov    $0x64,%edx
  10040f:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100410:	a8 01                	test   $0x1,%al
  100412:	74 45                	je     100459 <console_read_digit+0x4f>
  100414:	b2 60                	mov    $0x60,%dl
  100416:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100417:	8d 50 fe             	lea    -0x2(%eax),%edx
  10041a:	80 fa 08             	cmp    $0x8,%dl
  10041d:	77 05                	ja     100424 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10041f:	0f b6 c0             	movzbl %al,%eax
  100422:	48                   	dec    %eax
  100423:	c3                   	ret    
	else if (data == 0x0B)
  100424:	3c 0b                	cmp    $0xb,%al
  100426:	74 35                	je     10045d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100428:	8d 50 b9             	lea    -0x47(%eax),%edx
  10042b:	80 fa 02             	cmp    $0x2,%dl
  10042e:	77 07                	ja     100437 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100430:	0f b6 c0             	movzbl %al,%eax
  100433:	83 e8 40             	sub    $0x40,%eax
  100436:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100437:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10043a:	80 fa 02             	cmp    $0x2,%dl
  10043d:	77 07                	ja     100446 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10043f:	0f b6 c0             	movzbl %al,%eax
  100442:	83 e8 47             	sub    $0x47,%eax
  100445:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100446:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100449:	80 fa 02             	cmp    $0x2,%dl
  10044c:	77 07                	ja     100455 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10044e:	0f b6 c0             	movzbl %al,%eax
  100451:	83 e8 4e             	sub    $0x4e,%eax
  100454:	c3                   	ret    
	else if (data == 0x53)
  100455:	3c 53                	cmp    $0x53,%al
  100457:	74 04                	je     10045d <console_read_digit+0x53>
  100459:	83 c8 ff             	or     $0xffffffff,%eax
  10045c:	c3                   	ret    
  10045d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10045f:	c3                   	ret    

00100460 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100460:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100464:	a3 54 9f 10 00       	mov    %eax,0x109f54

	asm volatile("movl %0,%%esp\n\t"
  100469:	83 c0 04             	add    $0x4,%eax
  10046c:	89 c4                	mov    %eax,%esp
  10046e:	61                   	popa   
  10046f:	07                   	pop    %es
  100470:	1f                   	pop    %ds
  100471:	83 c4 08             	add    $0x8,%esp
  100474:	cf                   	iret   
  100475:	eb fe                	jmp    100475 <run+0x15>

00100477 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100477:	53                   	push   %ebx
  100478:	83 ec 0c             	sub    $0xc,%esp
  10047b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10047f:	6a 44                	push   $0x44
  100481:	6a 00                	push   $0x0
  100483:	8d 43 04             	lea    0x4(%ebx),%eax
  100486:	50                   	push   %eax
  100487:	e8 10 01 00 00       	call   10059c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10048c:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100492:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100498:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10049e:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  1004a4:	83 c4 18             	add    $0x18,%esp
  1004a7:	5b                   	pop    %ebx
  1004a8:	c3                   	ret    
  1004a9:	90                   	nop
  1004aa:	90                   	nop
  1004ab:	90                   	nop

001004ac <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004ac:	55                   	push   %ebp
  1004ad:	57                   	push   %edi
  1004ae:	56                   	push   %esi
  1004af:	53                   	push   %ebx
  1004b0:	83 ec 1c             	sub    $0x1c,%esp
  1004b3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004b7:	83 f8 01             	cmp    $0x1,%eax
  1004ba:	7f 04                	jg     1004c0 <program_loader+0x14>
  1004bc:	85 c0                	test   %eax,%eax
  1004be:	79 02                	jns    1004c2 <program_loader+0x16>
  1004c0:	eb fe                	jmp    1004c0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1004c2:	8b 34 c5 d0 1a 10 00 	mov    0x101ad0(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1004c9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1004cf:	74 02                	je     1004d3 <program_loader+0x27>
  1004d1:	eb fe                	jmp    1004d1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004d3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1004d6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004da:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1004dc:	c1 e5 05             	shl    $0x5,%ebp
  1004df:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1004e2:	eb 3f                	jmp    100523 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1004e4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1004e7:	75 37                	jne    100520 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1004e9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004ec:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1004ef:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004f2:	01 c7                	add    %eax,%edi
	memsz += va;
  1004f4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1004f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1004fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1004ff:	52                   	push   %edx
  100500:	89 fa                	mov    %edi,%edx
  100502:	29 c2                	sub    %eax,%edx
  100504:	52                   	push   %edx
  100505:	8b 53 04             	mov    0x4(%ebx),%edx
  100508:	01 f2                	add    %esi,%edx
  10050a:	52                   	push   %edx
  10050b:	50                   	push   %eax
  10050c:	e8 27 00 00 00       	call   100538 <memcpy>
  100511:	83 c4 10             	add    $0x10,%esp
  100514:	eb 04                	jmp    10051a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100516:	c6 07 00             	movb   $0x0,(%edi)
  100519:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10051a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10051e:	72 f6                	jb     100516 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100520:	83 c3 20             	add    $0x20,%ebx
  100523:	39 eb                	cmp    %ebp,%ebx
  100525:	72 bd                	jb     1004e4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100527:	8b 56 18             	mov    0x18(%esi),%edx
  10052a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10052e:	89 10                	mov    %edx,(%eax)
}
  100530:	83 c4 1c             	add    $0x1c,%esp
  100533:	5b                   	pop    %ebx
  100534:	5e                   	pop    %esi
  100535:	5f                   	pop    %edi
  100536:	5d                   	pop    %ebp
  100537:	c3                   	ret    

00100538 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100538:	56                   	push   %esi
  100539:	31 d2                	xor    %edx,%edx
  10053b:	53                   	push   %ebx
  10053c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100540:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100544:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100548:	eb 08                	jmp    100552 <memcpy+0x1a>
		*d++ = *s++;
  10054a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10054d:	4e                   	dec    %esi
  10054e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100551:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100552:	85 f6                	test   %esi,%esi
  100554:	75 f4                	jne    10054a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100556:	5b                   	pop    %ebx
  100557:	5e                   	pop    %esi
  100558:	c3                   	ret    

00100559 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100559:	57                   	push   %edi
  10055a:	56                   	push   %esi
  10055b:	53                   	push   %ebx
  10055c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100560:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100564:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100568:	39 c7                	cmp    %eax,%edi
  10056a:	73 26                	jae    100592 <memmove+0x39>
  10056c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10056f:	39 c6                	cmp    %eax,%esi
  100571:	76 1f                	jbe    100592 <memmove+0x39>
		s += n, d += n;
  100573:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100576:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100578:	eb 07                	jmp    100581 <memmove+0x28>
			*--d = *--s;
  10057a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10057d:	4a                   	dec    %edx
  10057e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100581:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100582:	85 d2                	test   %edx,%edx
  100584:	75 f4                	jne    10057a <memmove+0x21>
  100586:	eb 10                	jmp    100598 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100588:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10058b:	4a                   	dec    %edx
  10058c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10058f:	41                   	inc    %ecx
  100590:	eb 02                	jmp    100594 <memmove+0x3b>
  100592:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100594:	85 d2                	test   %edx,%edx
  100596:	75 f0                	jne    100588 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100598:	5b                   	pop    %ebx
  100599:	5e                   	pop    %esi
  10059a:	5f                   	pop    %edi
  10059b:	c3                   	ret    

0010059c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10059c:	53                   	push   %ebx
  10059d:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005a1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005a5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005a9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005ab:	eb 04                	jmp    1005b1 <memset+0x15>
		*p++ = c;
  1005ad:	88 1a                	mov    %bl,(%edx)
  1005af:	49                   	dec    %ecx
  1005b0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005b1:	85 c9                	test   %ecx,%ecx
  1005b3:	75 f8                	jne    1005ad <memset+0x11>
		*p++ = c;
	return v;
}
  1005b5:	5b                   	pop    %ebx
  1005b6:	c3                   	ret    

001005b7 <strlen>:

size_t
strlen(const char *s)
{
  1005b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005bb:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005bd:	eb 01                	jmp    1005c0 <strlen+0x9>
		++n;
  1005bf:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005c0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1005c4:	75 f9                	jne    1005bf <strlen+0x8>
		++n;
	return n;
}
  1005c6:	c3                   	ret    

001005c7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1005c7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1005cb:	31 c0                	xor    %eax,%eax
  1005cd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005d1:	eb 01                	jmp    1005d4 <strnlen+0xd>
		++n;
  1005d3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005d4:	39 d0                	cmp    %edx,%eax
  1005d6:	74 06                	je     1005de <strnlen+0x17>
  1005d8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1005dc:	75 f5                	jne    1005d3 <strnlen+0xc>
		++n;
	return n;
}
  1005de:	c3                   	ret    

001005df <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005df:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1005e0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005e5:	53                   	push   %ebx
  1005e6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1005e8:	76 05                	jbe    1005ef <console_putc+0x10>
  1005ea:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1005ef:	80 fa 0a             	cmp    $0xa,%dl
  1005f2:	75 2c                	jne    100620 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005f4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1005fa:	be 50 00 00 00       	mov    $0x50,%esi
  1005ff:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100601:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100604:	99                   	cltd   
  100605:	f7 fe                	idiv   %esi
  100607:	89 de                	mov    %ebx,%esi
  100609:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10060b:	eb 07                	jmp    100614 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10060d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100610:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100611:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100614:	83 f8 50             	cmp    $0x50,%eax
  100617:	75 f4                	jne    10060d <console_putc+0x2e>
  100619:	29 d0                	sub    %edx,%eax
  10061b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10061e:	eb 0b                	jmp    10062b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100620:	0f b6 d2             	movzbl %dl,%edx
  100623:	09 ca                	or     %ecx,%edx
  100625:	66 89 13             	mov    %dx,(%ebx)
  100628:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10062b:	5b                   	pop    %ebx
  10062c:	5e                   	pop    %esi
  10062d:	c3                   	ret    

0010062e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10062e:	56                   	push   %esi
  10062f:	53                   	push   %ebx
  100630:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100634:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100637:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10063b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100640:	75 04                	jne    100646 <fill_numbuf+0x18>
  100642:	85 d2                	test   %edx,%edx
  100644:	74 10                	je     100656 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100646:	89 d0                	mov    %edx,%eax
  100648:	31 d2                	xor    %edx,%edx
  10064a:	f7 f1                	div    %ecx
  10064c:	4b                   	dec    %ebx
  10064d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100650:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100652:	89 c2                	mov    %eax,%edx
  100654:	eb ec                	jmp    100642 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100656:	89 d8                	mov    %ebx,%eax
  100658:	5b                   	pop    %ebx
  100659:	5e                   	pop    %esi
  10065a:	c3                   	ret    

0010065b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10065b:	55                   	push   %ebp
  10065c:	57                   	push   %edi
  10065d:	56                   	push   %esi
  10065e:	53                   	push   %ebx
  10065f:	83 ec 38             	sub    $0x38,%esp
  100662:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100666:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10066a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10066e:	e9 60 03 00 00       	jmp    1009d3 <console_vprintf+0x378>
		if (*format != '%') {
  100673:	80 fa 25             	cmp    $0x25,%dl
  100676:	74 13                	je     10068b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100678:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10067c:	0f b6 d2             	movzbl %dl,%edx
  10067f:	89 f0                	mov    %esi,%eax
  100681:	e8 59 ff ff ff       	call   1005df <console_putc>
  100686:	e9 45 03 00 00       	jmp    1009d0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10068b:	47                   	inc    %edi
  10068c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100693:	00 
  100694:	eb 12                	jmp    1006a8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100696:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100697:	8a 11                	mov    (%ecx),%dl
  100699:	84 d2                	test   %dl,%dl
  10069b:	74 1a                	je     1006b7 <console_vprintf+0x5c>
  10069d:	89 e8                	mov    %ebp,%eax
  10069f:	38 c2                	cmp    %al,%dl
  1006a1:	75 f3                	jne    100696 <console_vprintf+0x3b>
  1006a3:	e9 3f 03 00 00       	jmp    1009e7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006a8:	8a 17                	mov    (%edi),%dl
  1006aa:	84 d2                	test   %dl,%dl
  1006ac:	74 0b                	je     1006b9 <console_vprintf+0x5e>
  1006ae:	b9 60 0a 10 00       	mov    $0x100a60,%ecx
  1006b3:	89 d5                	mov    %edx,%ebp
  1006b5:	eb e0                	jmp    100697 <console_vprintf+0x3c>
  1006b7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006b9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1006bc:	3c 08                	cmp    $0x8,%al
  1006be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1006c5:	00 
  1006c6:	76 13                	jbe    1006db <console_vprintf+0x80>
  1006c8:	eb 1d                	jmp    1006e7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1006ca:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1006cf:	0f be c0             	movsbl %al,%eax
  1006d2:	47                   	inc    %edi
  1006d3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1006d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1006db:	8a 07                	mov    (%edi),%al
  1006dd:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006e0:	80 fa 09             	cmp    $0x9,%dl
  1006e3:	76 e5                	jbe    1006ca <console_vprintf+0x6f>
  1006e5:	eb 18                	jmp    1006ff <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1006e7:	80 fa 2a             	cmp    $0x2a,%dl
  1006ea:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1006f1:	ff 
  1006f2:	75 0b                	jne    1006ff <console_vprintf+0xa4>
			width = va_arg(val, int);
  1006f4:	83 c3 04             	add    $0x4,%ebx
			++format;
  1006f7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1006f8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1006ff:	83 cd ff             	or     $0xffffffff,%ebp
  100702:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100705:	75 37                	jne    10073e <console_vprintf+0xe3>
			++format;
  100707:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100708:	31 ed                	xor    %ebp,%ebp
  10070a:	8a 07                	mov    (%edi),%al
  10070c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10070f:	80 fa 09             	cmp    $0x9,%dl
  100712:	76 0d                	jbe    100721 <console_vprintf+0xc6>
  100714:	eb 17                	jmp    10072d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100716:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100719:	0f be c0             	movsbl %al,%eax
  10071c:	47                   	inc    %edi
  10071d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100721:	8a 07                	mov    (%edi),%al
  100723:	8d 50 d0             	lea    -0x30(%eax),%edx
  100726:	80 fa 09             	cmp    $0x9,%dl
  100729:	76 eb                	jbe    100716 <console_vprintf+0xbb>
  10072b:	eb 11                	jmp    10073e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10072d:	3c 2a                	cmp    $0x2a,%al
  10072f:	75 0b                	jne    10073c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100731:	83 c3 04             	add    $0x4,%ebx
				++format;
  100734:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100735:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100738:	85 ed                	test   %ebp,%ebp
  10073a:	79 02                	jns    10073e <console_vprintf+0xe3>
  10073c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10073e:	8a 07                	mov    (%edi),%al
  100740:	3c 64                	cmp    $0x64,%al
  100742:	74 34                	je     100778 <console_vprintf+0x11d>
  100744:	7f 1d                	jg     100763 <console_vprintf+0x108>
  100746:	3c 58                	cmp    $0x58,%al
  100748:	0f 84 a2 00 00 00    	je     1007f0 <console_vprintf+0x195>
  10074e:	3c 63                	cmp    $0x63,%al
  100750:	0f 84 bf 00 00 00    	je     100815 <console_vprintf+0x1ba>
  100756:	3c 43                	cmp    $0x43,%al
  100758:	0f 85 d0 00 00 00    	jne    10082e <console_vprintf+0x1d3>
  10075e:	e9 a3 00 00 00       	jmp    100806 <console_vprintf+0x1ab>
  100763:	3c 75                	cmp    $0x75,%al
  100765:	74 4d                	je     1007b4 <console_vprintf+0x159>
  100767:	3c 78                	cmp    $0x78,%al
  100769:	74 5c                	je     1007c7 <console_vprintf+0x16c>
  10076b:	3c 73                	cmp    $0x73,%al
  10076d:	0f 85 bb 00 00 00    	jne    10082e <console_vprintf+0x1d3>
  100773:	e9 86 00 00 00       	jmp    1007fe <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100778:	83 c3 04             	add    $0x4,%ebx
  10077b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10077e:	89 d1                	mov    %edx,%ecx
  100780:	c1 f9 1f             	sar    $0x1f,%ecx
  100783:	89 0c 24             	mov    %ecx,(%esp)
  100786:	31 ca                	xor    %ecx,%edx
  100788:	55                   	push   %ebp
  100789:	29 ca                	sub    %ecx,%edx
  10078b:	68 68 0a 10 00       	push   $0x100a68
  100790:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100795:	8d 44 24 40          	lea    0x40(%esp),%eax
  100799:	e8 90 fe ff ff       	call   10062e <fill_numbuf>
  10079e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007a2:	58                   	pop    %eax
  1007a3:	5a                   	pop    %edx
  1007a4:	ba 01 00 00 00       	mov    $0x1,%edx
  1007a9:	8b 04 24             	mov    (%esp),%eax
  1007ac:	83 e0 01             	and    $0x1,%eax
  1007af:	e9 a5 00 00 00       	jmp    100859 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007b4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007bc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007bf:	55                   	push   %ebp
  1007c0:	68 68 0a 10 00       	push   $0x100a68
  1007c5:	eb 11                	jmp    1007d8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1007c7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1007ca:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007cd:	55                   	push   %ebp
  1007ce:	68 7c 0a 10 00       	push   $0x100a7c
  1007d3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1007d8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007dc:	e8 4d fe ff ff       	call   10062e <fill_numbuf>
  1007e1:	ba 01 00 00 00       	mov    $0x1,%edx
  1007e6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1007ea:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1007ec:	59                   	pop    %ecx
  1007ed:	59                   	pop    %ecx
  1007ee:	eb 69                	jmp    100859 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1007f0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1007f3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007f6:	55                   	push   %ebp
  1007f7:	68 68 0a 10 00       	push   $0x100a68
  1007fc:	eb d5                	jmp    1007d3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1007fe:	83 c3 04             	add    $0x4,%ebx
  100801:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100804:	eb 40                	jmp    100846 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100806:	83 c3 04             	add    $0x4,%ebx
  100809:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10080c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100810:	e9 bd 01 00 00       	jmp    1009d2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100815:	83 c3 04             	add    $0x4,%ebx
  100818:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10081b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10081f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100824:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100828:	88 44 24 24          	mov    %al,0x24(%esp)
  10082c:	eb 27                	jmp    100855 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10082e:	84 c0                	test   %al,%al
  100830:	75 02                	jne    100834 <console_vprintf+0x1d9>
  100832:	b0 25                	mov    $0x25,%al
  100834:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100838:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10083d:	80 3f 00             	cmpb   $0x0,(%edi)
  100840:	74 0a                	je     10084c <console_vprintf+0x1f1>
  100842:	8d 44 24 24          	lea    0x24(%esp),%eax
  100846:	89 44 24 04          	mov    %eax,0x4(%esp)
  10084a:	eb 09                	jmp    100855 <console_vprintf+0x1fa>
				format--;
  10084c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100850:	4f                   	dec    %edi
  100851:	89 54 24 04          	mov    %edx,0x4(%esp)
  100855:	31 d2                	xor    %edx,%edx
  100857:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100859:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10085b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10085e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100865:	74 1f                	je     100886 <console_vprintf+0x22b>
  100867:	89 04 24             	mov    %eax,(%esp)
  10086a:	eb 01                	jmp    10086d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10086c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10086d:	39 e9                	cmp    %ebp,%ecx
  10086f:	74 0a                	je     10087b <console_vprintf+0x220>
  100871:	8b 44 24 04          	mov    0x4(%esp),%eax
  100875:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100879:	75 f1                	jne    10086c <console_vprintf+0x211>
  10087b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10087e:	89 0c 24             	mov    %ecx,(%esp)
  100881:	eb 1f                	jmp    1008a2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100883:	42                   	inc    %edx
  100884:	eb 09                	jmp    10088f <console_vprintf+0x234>
  100886:	89 d1                	mov    %edx,%ecx
  100888:	8b 14 24             	mov    (%esp),%edx
  10088b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10088f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100893:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100897:	75 ea                	jne    100883 <console_vprintf+0x228>
  100899:	8b 44 24 08          	mov    0x8(%esp),%eax
  10089d:	89 14 24             	mov    %edx,(%esp)
  1008a0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008a2:	85 c0                	test   %eax,%eax
  1008a4:	74 0c                	je     1008b2 <console_vprintf+0x257>
  1008a6:	84 d2                	test   %dl,%dl
  1008a8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008af:	00 
  1008b0:	75 24                	jne    1008d6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008b2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008b7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1008be:	00 
  1008bf:	75 15                	jne    1008d6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1008c1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008c5:	83 e0 08             	and    $0x8,%eax
  1008c8:	83 f8 01             	cmp    $0x1,%eax
  1008cb:	19 c9                	sbb    %ecx,%ecx
  1008cd:	f7 d1                	not    %ecx
  1008cf:	83 e1 20             	and    $0x20,%ecx
  1008d2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1008d6:	3b 2c 24             	cmp    (%esp),%ebp
  1008d9:	7e 0d                	jle    1008e8 <console_vprintf+0x28d>
  1008db:	84 d2                	test   %dl,%dl
  1008dd:	74 40                	je     10091f <console_vprintf+0x2c4>
			zeros = precision - len;
  1008df:	2b 2c 24             	sub    (%esp),%ebp
  1008e2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1008e6:	eb 3f                	jmp    100927 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008e8:	84 d2                	test   %dl,%dl
  1008ea:	74 33                	je     10091f <console_vprintf+0x2c4>
  1008ec:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008f0:	83 e0 06             	and    $0x6,%eax
  1008f3:	83 f8 02             	cmp    $0x2,%eax
  1008f6:	75 27                	jne    10091f <console_vprintf+0x2c4>
  1008f8:	45                   	inc    %ebp
  1008f9:	75 24                	jne    10091f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008fb:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008fd:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100900:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100905:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100908:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10090b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10090f:	7d 0e                	jge    10091f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100911:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100915:	29 ca                	sub    %ecx,%edx
  100917:	29 c2                	sub    %eax,%edx
  100919:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10091d:	eb 08                	jmp    100927 <console_vprintf+0x2cc>
  10091f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100926:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100927:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10092b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10092d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100931:	2b 2c 24             	sub    (%esp),%ebp
  100934:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100939:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10093c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10093f:	29 c5                	sub    %eax,%ebp
  100941:	89 f0                	mov    %esi,%eax
  100943:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100947:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10094b:	eb 0f                	jmp    10095c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  10094d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100951:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100956:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100957:	e8 83 fc ff ff       	call   1005df <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10095c:	85 ed                	test   %ebp,%ebp
  10095e:	7e 07                	jle    100967 <console_vprintf+0x30c>
  100960:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100965:	74 e6                	je     10094d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100967:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10096c:	89 c6                	mov    %eax,%esi
  10096e:	74 23                	je     100993 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100970:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100975:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100979:	e8 61 fc ff ff       	call   1005df <console_putc>
  10097e:	89 c6                	mov    %eax,%esi
  100980:	eb 11                	jmp    100993 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100982:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100986:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  10098b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  10098c:	e8 4e fc ff ff       	call   1005df <console_putc>
  100991:	eb 06                	jmp    100999 <console_vprintf+0x33e>
  100993:	89 f0                	mov    %esi,%eax
  100995:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100999:	85 f6                	test   %esi,%esi
  10099b:	7f e5                	jg     100982 <console_vprintf+0x327>
  10099d:	8b 34 24             	mov    (%esp),%esi
  1009a0:	eb 15                	jmp    1009b7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009a2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009a6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009a7:	0f b6 11             	movzbl (%ecx),%edx
  1009aa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009ae:	e8 2c fc ff ff       	call   1005df <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009b3:	ff 44 24 04          	incl   0x4(%esp)
  1009b7:	85 f6                	test   %esi,%esi
  1009b9:	7f e7                	jg     1009a2 <console_vprintf+0x347>
  1009bb:	eb 0f                	jmp    1009cc <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1009bd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009c1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009c6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009c7:	e8 13 fc ff ff       	call   1005df <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009cc:	85 ed                	test   %ebp,%ebp
  1009ce:	7f ed                	jg     1009bd <console_vprintf+0x362>
  1009d0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1009d2:	47                   	inc    %edi
  1009d3:	8a 17                	mov    (%edi),%dl
  1009d5:	84 d2                	test   %dl,%dl
  1009d7:	0f 85 96 fc ff ff    	jne    100673 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1009dd:	83 c4 38             	add    $0x38,%esp
  1009e0:	89 f0                	mov    %esi,%eax
  1009e2:	5b                   	pop    %ebx
  1009e3:	5e                   	pop    %esi
  1009e4:	5f                   	pop    %edi
  1009e5:	5d                   	pop    %ebp
  1009e6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009e7:	81 e9 60 0a 10 00    	sub    $0x100a60,%ecx
  1009ed:	b8 01 00 00 00       	mov    $0x1,%eax
  1009f2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1009f4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009f5:	09 44 24 14          	or     %eax,0x14(%esp)
  1009f9:	e9 aa fc ff ff       	jmp    1006a8 <console_vprintf+0x4d>

001009fe <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  1009fe:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a02:	50                   	push   %eax
  100a03:	ff 74 24 10          	pushl  0x10(%esp)
  100a07:	ff 74 24 10          	pushl  0x10(%esp)
  100a0b:	ff 74 24 10          	pushl  0x10(%esp)
  100a0f:	e8 47 fc ff ff       	call   10065b <console_vprintf>
  100a14:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a17:	c3                   	ret    
