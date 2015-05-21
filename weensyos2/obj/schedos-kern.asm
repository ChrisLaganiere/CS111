
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 e3 01 00 00       	call   1001fc <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 19 01 00 00       	call   10018b <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	56                   	push   %esi
  10009d:	53                   	push   %ebx
  10009e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000a1:	a1 7c 8c 10 00       	mov    0x108c7c,%eax
  1000a6:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a8:	a1 80 8c 10 00       	mov    0x108c80,%eax
  1000ad:	85 c0                	test   %eax,%eax
  1000af:	75 1c                	jne    1000cd <schedule+0x31>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b1:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b6:	8d 42 01             	lea    0x1(%edx),%eax
  1000b9:	99                   	cltd   
  1000ba:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bc:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bf:	83 b8 b8 82 10 00 01 	cmpl   $0x1,0x1082b8(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
				run(&proc_array[pid]);
  1000c8:	83 ec 0c             	sub    $0xc,%esp
  1000cb:	eb 47                	jmp    100114 <schedule+0x78>
		}

	else if (scheduling_algorithm == 1) {
  1000cd:	83 f8 01             	cmp    $0x1,%eax
  1000d0:	75 4d                	jne    10011f <schedule+0x83>
  1000d2:	83 c8 ff             	or     $0xffffffff,%eax
  1000d5:	ba 01 00 00 00       	mov    $0x1,%edx
  1000da:	eb 1f                	jmp    1000fb <schedule+0x5f>
		int smallest_pid;
		while (1) {
			// first get smallest pid
			smallest_pid = -1;
			for (i = 1; i < NPROCS; i++) {
				process_t *proc = &proc_array[i];
  1000dc:	6b ca 54             	imul   $0x54,%edx,%ecx
				if (proc->p_state == P_RUNNABLE && (smallest_pid < 0 || proc->p_pid < smallest_pid)) {
  1000df:	83 b9 b8 82 10 00 01 	cmpl   $0x1,0x1082b8(%ecx)
  1000e6:	75 12                	jne    1000fa <schedule+0x5e>
  1000e8:	85 c0                	test   %eax,%eax
  1000ea:	78 08                	js     1000f4 <schedule+0x58>
  1000ec:	39 81 70 82 10 00    	cmp    %eax,0x108270(%ecx)
  1000f2:	7d 06                	jge    1000fa <schedule+0x5e>
					smallest_pid = proc->p_pid;
  1000f4:	8b 81 70 82 10 00    	mov    0x108270(%ecx),%eax
		int i;
		int smallest_pid;
		while (1) {
			// first get smallest pid
			smallest_pid = -1;
			for (i = 1; i < NPROCS; i++) {
  1000fa:	42                   	inc    %edx
  1000fb:	83 fa 04             	cmp    $0x4,%edx
  1000fe:	7e dc                	jle    1000dc <schedule+0x40>
				if (proc->p_state == P_RUNNABLE && (smallest_pid < 0 || proc->p_pid < smallest_pid)) {
					smallest_pid = proc->p_pid;
				}
			}
			// run it if possible
			if (smallest_pid > 0) {
  100100:	85 c0                	test   %eax,%eax
  100102:	7f 0a                	jg     10010e <schedule+0x72>
  100104:	83 c8 ff             	or     $0xffffffff,%eax
  100107:	ba 01 00 00 00       	mov    $0x1,%edx
  10010c:	eb ce                	jmp    1000dc <schedule+0x40>
				run(&proc_array[smallest_pid]);
  10010e:	6b c0 54             	imul   $0x54,%eax,%eax
  100111:	83 ec 0c             	sub    $0xc,%esp
  100114:	05 70 82 10 00       	add    $0x108270,%eax
  100119:	50                   	push   %eax
  10011a:	e8 b6 03 00 00       	call   1004d5 <run>
			}
		}
	}

	else if (scheduling_algorithm == 2) {
  10011f:	83 f8 02             	cmp    $0x2,%eax
  100122:	75 46                	jne    10016a <schedule+0xce>
					hp_priority = proc->p_priority;
				}
			}

			// go through processes and run them if they're highest priority
			pid = (pid + 1) % NPROCS;
  100124:	bb 05 00 00 00       	mov    $0x5,%ebx
				run(&proc_array[smallest_pid]);
			}
		}
	}

	else if (scheduling_algorithm == 2) {
  100129:	31 c0                	xor    %eax,%eax
  10012b:	31 c9                	xor    %ecx,%ecx
		while (1) {
			hp_priority = 0;
			// first find highest priority
			for (i = 1; i < NPROCS; i++) {
				process_t *proc = &proc_array[i];
				if (proc->p_state == P_RUNNABLE && proc->p_priority > hp_priority) {
  10012d:	83 b8 0c 83 10 00 01 	cmpl   $0x1,0x10830c(%eax)
  100134:	75 0c                	jne    100142 <schedule+0xa6>
  100136:	8b b0 14 83 10 00    	mov    0x108314(%eax),%esi
  10013c:	39 f1                	cmp    %esi,%ecx
  10013e:	7d 02                	jge    100142 <schedule+0xa6>
  100140:	89 f1                	mov    %esi,%ecx
  100142:	83 c0 54             	add    $0x54,%eax
		int i;
		int hp_priority;
		while (1) {
			hp_priority = 0;
			// first find highest priority
			for (i = 1; i < NPROCS; i++) {
  100145:	3d 50 01 00 00       	cmp    $0x150,%eax
  10014a:	75 e1                	jne    10012d <schedule+0x91>
					hp_priority = proc->p_priority;
				}
			}

			// go through processes and run them if they're highest priority
			pid = (pid + 1) % NPROCS;
  10014c:	8d 42 01             	lea    0x1(%edx),%eax
  10014f:	99                   	cltd   
  100150:	f7 fb                	idiv   %ebx
			process_t *proc = &proc_array[pid];
  100152:	6b c2 54             	imul   $0x54,%edx,%eax
  100155:	05 70 82 10 00       	add    $0x108270,%eax
			if (proc->p_state == P_RUNNABLE && proc->p_priority == hp_priority) {
  10015a:	83 78 48 01          	cmpl   $0x1,0x48(%eax)
  10015e:	75 c9                	jne    100129 <schedule+0x8d>
  100160:	39 48 50             	cmp    %ecx,0x50(%eax)
  100163:	75 c4                	jne    100129 <schedule+0x8d>
				run(proc);
  100165:	83 ec 0c             	sub    $0xc,%esp
  100168:	eb af                	jmp    100119 <schedule+0x7d>
			}
		}
	}

	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10016a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100170:	50                   	push   %eax
  100171:	68 94 0a 10 00       	push   $0x100a94
  100176:	68 00 01 00 00       	push   $0x100
  10017b:	52                   	push   %edx
  10017c:	e8 f9 08 00 00       	call   100a7a <console_printf>
  100181:	83 c4 10             	add    $0x10,%esp
  100184:	a3 00 80 19 00       	mov    %eax,0x198000
  100189:	eb fe                	jmp    100189 <schedule+0xed>

0010018b <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10018b:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10018c:	a1 7c 8c 10 00       	mov    0x108c7c,%eax
  100191:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100196:	56                   	push   %esi
  100197:	53                   	push   %ebx
  100198:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10019c:	8d 78 04             	lea    0x4(%eax),%edi
  10019f:	89 de                	mov    %ebx,%esi
  1001a1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001a3:	8b 53 28             	mov    0x28(%ebx),%edx
  1001a6:	83 fa 31             	cmp    $0x31,%edx
  1001a9:	74 1f                	je     1001ca <interrupt+0x3f>
  1001ab:	77 0c                	ja     1001b9 <interrupt+0x2e>
  1001ad:	83 fa 20             	cmp    $0x20,%edx
  1001b0:	74 43                	je     1001f5 <interrupt+0x6a>
  1001b2:	83 fa 30             	cmp    $0x30,%edx
  1001b5:	74 0e                	je     1001c5 <interrupt+0x3a>
  1001b7:	eb 41                	jmp    1001fa <interrupt+0x6f>
  1001b9:	83 fa 32             	cmp    $0x32,%edx
  1001bc:	74 23                	je     1001e1 <interrupt+0x56>
  1001be:	83 fa 33             	cmp    $0x33,%edx
  1001c1:	74 29                	je     1001ec <interrupt+0x61>
  1001c3:	eb 35                	jmp    1001fa <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001c5:	e8 d2 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001ca:	a1 7c 8c 10 00       	mov    0x108c7c,%eax
		current->p_exit_status = reg->reg_eax;
  1001cf:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001d2:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001d9:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001dc:	e8 bb fe ff ff       	call   10009c <schedule>
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */

		// I use this interrupt to set the p_priority of the process for exercise 4A
		current->p_priority = reg->reg_ebx;
  1001e1:	a1 7c 8c 10 00       	mov    0x108c7c,%eax
  1001e6:	8b 53 10             	mov    0x10(%ebx),%edx
  1001e9:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001ec:	83 ec 0c             	sub    $0xc,%esp
  1001ef:	50                   	push   %eax
  1001f0:	e8 e0 02 00 00       	call   1004d5 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001f5:	e8 a2 fe ff ff       	call   10009c <schedule>
  1001fa:	eb fe                	jmp    1001fa <interrupt+0x6f>

001001fc <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001fc:	57                   	push   %edi
  1001fd:	56                   	push   %esi
  1001fe:	53                   	push   %ebx
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001ff:	e8 b0 00 00 00       	call   1002b4 <segments_init>
	interrupt_controller_init(1);
  100204:	83 ec 0c             	sub    $0xc,%esp
  100207:	6a 01                	push   $0x1
  100209:	e8 a1 01 00 00       	call   1003af <interrupt_controller_init>
	console_clear();
  10020e:	e8 25 02 00 00       	call   100438 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100213:	83 c4 0c             	add    $0xc,%esp
  100216:	68 a4 01 00 00       	push   $0x1a4
  10021b:	6a 00                	push   $0x0
  10021d:	68 70 82 10 00       	push   $0x108270
  100222:	e8 f1 03 00 00       	call   100618 <memset>
  100227:	b8 70 82 10 00       	mov    $0x108270,%eax
  10022c:	31 d2                	xor    %edx,%edx
  10022e:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100231:	89 10                	mov    %edx,(%eax)
	interrupt_controller_init(1);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100233:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100234:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_priority = 5;
  10023b:	c7 40 50 05 00 00 00 	movl   $0x5,0x50(%eax)
	interrupt_controller_init(1);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100242:	83 c0 54             	add    $0x54,%eax
  100245:	83 fa 05             	cmp    $0x5,%edx
  100248:	75 e7                	jne    100231 <start+0x35>
  10024a:	bb c4 82 10 00       	mov    $0x1082c4,%ebx
  10024f:	bf 00 00 30 00       	mov    $0x300000,%edi
  100254:	31 f6                	xor    %esi,%esi
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100256:	83 ec 0c             	sub    $0xc,%esp
  100259:	53                   	push   %ebx
  10025a:	e8 8d 02 00 00       	call   1004ec <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10025f:	58                   	pop    %eax
  100260:	5a                   	pop    %edx
  100261:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100264:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100267:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10026d:	50                   	push   %eax
  10026e:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10026f:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100270:	e8 b3 02 00 00       	call   100528 <program_loader>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_priority = 5;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100275:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100278:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  10027f:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_priority = 5;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100282:	83 fe 04             	cmp    $0x4,%esi
  100285:	75 cf                	jne    100256 <start+0x5a>

	// Exercise 6:  set the lock to 0 so the first process can run
	lock = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  100287:	83 ec 0c             	sub    $0xc,%esp
  10028a:	68 c4 82 10 00       	push   $0x1082c4
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10028f:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100296:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;
  100299:	c7 05 80 8c 10 00 00 	movl   $0x0,0x108c80
  1002a0:	00 00 00 

	// Exercise 6:  set the lock to 0 so the first process can run
	lock = 0;
  1002a3:	c7 05 04 80 19 00 00 	movl   $0x0,0x198004
  1002aa:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1002ad:	e8 23 02 00 00       	call   1004d5 <run>
  1002b2:	90                   	nop
  1002b3:	90                   	nop

001002b4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b4:	b8 14 84 10 00       	mov    $0x108414,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b9:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002be:	89 c2                	mov    %eax,%edx
  1002c0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002c3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c4:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002c9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002cc:	66 a3 22 1b 10 00    	mov    %ax,0x101b22
  1002d2:	c1 e8 18             	shr    $0x18,%eax
  1002d5:	88 15 24 1b 10 00    	mov    %dl,0x101b24
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002db:	ba 7c 84 10 00       	mov    $0x10847c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e0:	a2 27 1b 10 00       	mov    %al,0x101b27
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e7:	66 c7 05 20 1b 10 00 	movw   $0x68,0x101b20
  1002ee:	68 00 
  1002f0:	c6 05 26 1b 10 00 40 	movb   $0x40,0x101b26
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002f7:	c6 05 25 1b 10 00 89 	movb   $0x89,0x101b25

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002fe:	c7 05 18 84 10 00 00 	movl   $0x180000,0x108418
  100305:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100308:	66 c7 05 1c 84 10 00 	movw   $0x10,0x10841c
  10030f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100311:	66 89 0c c5 7c 84 10 	mov    %cx,0x10847c(,%eax,8)
  100318:	00 
  100319:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100320:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100325:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10032a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10032f:	40                   	inc    %eax
  100330:	3d 00 01 00 00       	cmp    $0x100,%eax
  100335:	75 da                	jne    100311 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100337:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10033c:	ba 7c 84 10 00       	mov    $0x10847c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100341:	66 a3 7c 85 10 00    	mov    %ax,0x10857c
  100347:	c1 e8 10             	shr    $0x10,%eax
  10034a:	66 a3 82 85 10 00    	mov    %ax,0x108582
  100350:	b8 30 00 00 00       	mov    $0x30,%eax
  100355:	66 c7 05 7e 85 10 00 	movw   $0x8,0x10857e
  10035c:	08 00 
  10035e:	c6 05 80 85 10 00 00 	movb   $0x0,0x108580
  100365:	c6 05 81 85 10 00 8e 	movb   $0x8e,0x108581

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10036c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100373:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10037a:	66 89 0c c5 7c 84 10 	mov    %cx,0x10847c(,%eax,8)
  100381:	00 
  100382:	c1 e9 10             	shr    $0x10,%ecx
  100385:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10038a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10038f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100394:	40                   	inc    %eax
  100395:	83 f8 3a             	cmp    $0x3a,%eax
  100398:	75 d2                	jne    10036c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10039a:	b0 28                	mov    $0x28,%al
  10039c:	0f 01 15 e8 1a 10 00 	lgdtl  0x101ae8
  1003a3:	0f 00 d8             	ltr    %ax
  1003a6:	0f 01 1d f0 1a 10 00 	lidtl  0x101af0
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003ad:	5b                   	pop    %ebx
  1003ae:	c3                   	ret    

001003af <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003af:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003b0:	b0 ff                	mov    $0xff,%al
  1003b2:	57                   	push   %edi
  1003b3:	56                   	push   %esi
  1003b4:	53                   	push   %ebx
  1003b5:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003ba:	89 da                	mov    %ebx,%edx
  1003bc:	ee                   	out    %al,(%dx)
  1003bd:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003c2:	89 ca                	mov    %ecx,%edx
  1003c4:	ee                   	out    %al,(%dx)
  1003c5:	be 11 00 00 00       	mov    $0x11,%esi
  1003ca:	bf 20 00 00 00       	mov    $0x20,%edi
  1003cf:	89 f0                	mov    %esi,%eax
  1003d1:	89 fa                	mov    %edi,%edx
  1003d3:	ee                   	out    %al,(%dx)
  1003d4:	b0 20                	mov    $0x20,%al
  1003d6:	89 da                	mov    %ebx,%edx
  1003d8:	ee                   	out    %al,(%dx)
  1003d9:	b0 04                	mov    $0x4,%al
  1003db:	ee                   	out    %al,(%dx)
  1003dc:	b0 03                	mov    $0x3,%al
  1003de:	ee                   	out    %al,(%dx)
  1003df:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003e4:	89 f0                	mov    %esi,%eax
  1003e6:	89 ea                	mov    %ebp,%edx
  1003e8:	ee                   	out    %al,(%dx)
  1003e9:	b0 28                	mov    $0x28,%al
  1003eb:	89 ca                	mov    %ecx,%edx
  1003ed:	ee                   	out    %al,(%dx)
  1003ee:	b0 02                	mov    $0x2,%al
  1003f0:	ee                   	out    %al,(%dx)
  1003f1:	b0 01                	mov    $0x1,%al
  1003f3:	ee                   	out    %al,(%dx)
  1003f4:	b0 68                	mov    $0x68,%al
  1003f6:	89 fa                	mov    %edi,%edx
  1003f8:	ee                   	out    %al,(%dx)
  1003f9:	be 0a 00 00 00       	mov    $0xa,%esi
  1003fe:	89 f0                	mov    %esi,%eax
  100400:	ee                   	out    %al,(%dx)
  100401:	b0 68                	mov    $0x68,%al
  100403:	89 ea                	mov    %ebp,%edx
  100405:	ee                   	out    %al,(%dx)
  100406:	89 f0                	mov    %esi,%eax
  100408:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100409:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10040e:	89 da                	mov    %ebx,%edx
  100410:	19 c0                	sbb    %eax,%eax
  100412:	f7 d0                	not    %eax
  100414:	05 ff 00 00 00       	add    $0xff,%eax
  100419:	ee                   	out    %al,(%dx)
  10041a:	b0 ff                	mov    $0xff,%al
  10041c:	89 ca                	mov    %ecx,%edx
  10041e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10041f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100424:	74 0d                	je     100433 <interrupt_controller_init+0x84>
  100426:	b2 43                	mov    $0x43,%dl
  100428:	b0 34                	mov    $0x34,%al
  10042a:	ee                   	out    %al,(%dx)
  10042b:	b0 a9                	mov    $0xa9,%al
  10042d:	b2 40                	mov    $0x40,%dl
  10042f:	ee                   	out    %al,(%dx)
  100430:	b0 04                	mov    $0x4,%al
  100432:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100433:	5b                   	pop    %ebx
  100434:	5e                   	pop    %esi
  100435:	5f                   	pop    %edi
  100436:	5d                   	pop    %ebp
  100437:	c3                   	ret    

00100438 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100438:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100439:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10043b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10043c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100443:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100446:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10044c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100452:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100455:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10045a:	75 ea                	jne    100446 <console_clear+0xe>
  10045c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100461:	b0 0e                	mov    $0xe,%al
  100463:	89 f2                	mov    %esi,%edx
  100465:	ee                   	out    %al,(%dx)
  100466:	31 c9                	xor    %ecx,%ecx
  100468:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10046d:	88 c8                	mov    %cl,%al
  10046f:	89 da                	mov    %ebx,%edx
  100471:	ee                   	out    %al,(%dx)
  100472:	b0 0f                	mov    $0xf,%al
  100474:	89 f2                	mov    %esi,%edx
  100476:	ee                   	out    %al,(%dx)
  100477:	88 c8                	mov    %cl,%al
  100479:	89 da                	mov    %ebx,%edx
  10047b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10047c:	5b                   	pop    %ebx
  10047d:	5e                   	pop    %esi
  10047e:	c3                   	ret    

0010047f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10047f:	ba 64 00 00 00       	mov    $0x64,%edx
  100484:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100485:	a8 01                	test   $0x1,%al
  100487:	74 45                	je     1004ce <console_read_digit+0x4f>
  100489:	b2 60                	mov    $0x60,%dl
  10048b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10048c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10048f:	80 fa 08             	cmp    $0x8,%dl
  100492:	77 05                	ja     100499 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100494:	0f b6 c0             	movzbl %al,%eax
  100497:	48                   	dec    %eax
  100498:	c3                   	ret    
	else if (data == 0x0B)
  100499:	3c 0b                	cmp    $0xb,%al
  10049b:	74 35                	je     1004d2 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10049d:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004a0:	80 fa 02             	cmp    $0x2,%dl
  1004a3:	77 07                	ja     1004ac <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004a5:	0f b6 c0             	movzbl %al,%eax
  1004a8:	83 e8 40             	sub    $0x40,%eax
  1004ab:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004ac:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004af:	80 fa 02             	cmp    $0x2,%dl
  1004b2:	77 07                	ja     1004bb <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004b4:	0f b6 c0             	movzbl %al,%eax
  1004b7:	83 e8 47             	sub    $0x47,%eax
  1004ba:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004bb:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004be:	80 fa 02             	cmp    $0x2,%dl
  1004c1:	77 07                	ja     1004ca <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004c3:	0f b6 c0             	movzbl %al,%eax
  1004c6:	83 e8 4e             	sub    $0x4e,%eax
  1004c9:	c3                   	ret    
	else if (data == 0x53)
  1004ca:	3c 53                	cmp    $0x53,%al
  1004cc:	74 04                	je     1004d2 <console_read_digit+0x53>
  1004ce:	83 c8 ff             	or     $0xffffffff,%eax
  1004d1:	c3                   	ret    
  1004d2:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004d4:	c3                   	ret    

001004d5 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004d5:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004d9:	a3 7c 8c 10 00       	mov    %eax,0x108c7c

	asm volatile("movl %0,%%esp\n\t"
  1004de:	83 c0 04             	add    $0x4,%eax
  1004e1:	89 c4                	mov    %eax,%esp
  1004e3:	61                   	popa   
  1004e4:	07                   	pop    %es
  1004e5:	1f                   	pop    %ds
  1004e6:	83 c4 08             	add    $0x8,%esp
  1004e9:	cf                   	iret   
  1004ea:	eb fe                	jmp    1004ea <run+0x15>

001004ec <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004ec:	53                   	push   %ebx
  1004ed:	83 ec 0c             	sub    $0xc,%esp
  1004f0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004f4:	6a 44                	push   $0x44
  1004f6:	6a 00                	push   $0x0
  1004f8:	8d 43 04             	lea    0x4(%ebx),%eax
  1004fb:	50                   	push   %eax
  1004fc:	e8 17 01 00 00       	call   100618 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100501:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100507:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10050d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100513:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100519:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100520:	83 c4 18             	add    $0x18,%esp
  100523:	5b                   	pop    %ebx
  100524:	c3                   	ret    
  100525:	90                   	nop
  100526:	90                   	nop
  100527:	90                   	nop

00100528 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100528:	55                   	push   %ebp
  100529:	57                   	push   %edi
  10052a:	56                   	push   %esi
  10052b:	53                   	push   %ebx
  10052c:	83 ec 1c             	sub    $0x1c,%esp
  10052f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100533:	83 f8 03             	cmp    $0x3,%eax
  100536:	7f 04                	jg     10053c <program_loader+0x14>
  100538:	85 c0                	test   %eax,%eax
  10053a:	79 02                	jns    10053e <program_loader+0x16>
  10053c:	eb fe                	jmp    10053c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10053e:	8b 34 c5 28 1b 10 00 	mov    0x101b28(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100545:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10054b:	74 02                	je     10054f <program_loader+0x27>
  10054d:	eb fe                	jmp    10054d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10054f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100552:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100556:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100558:	c1 e5 05             	shl    $0x5,%ebp
  10055b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10055e:	eb 3f                	jmp    10059f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100560:	83 3b 01             	cmpl   $0x1,(%ebx)
  100563:	75 37                	jne    10059c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100565:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100568:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10056b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10056e:	01 c7                	add    %eax,%edi
	memsz += va;
  100570:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100572:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100577:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10057b:	52                   	push   %edx
  10057c:	89 fa                	mov    %edi,%edx
  10057e:	29 c2                	sub    %eax,%edx
  100580:	52                   	push   %edx
  100581:	8b 53 04             	mov    0x4(%ebx),%edx
  100584:	01 f2                	add    %esi,%edx
  100586:	52                   	push   %edx
  100587:	50                   	push   %eax
  100588:	e8 27 00 00 00       	call   1005b4 <memcpy>
  10058d:	83 c4 10             	add    $0x10,%esp
  100590:	eb 04                	jmp    100596 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100592:	c6 07 00             	movb   $0x0,(%edi)
  100595:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100596:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10059a:	72 f6                	jb     100592 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10059c:	83 c3 20             	add    $0x20,%ebx
  10059f:	39 eb                	cmp    %ebp,%ebx
  1005a1:	72 bd                	jb     100560 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005a3:	8b 56 18             	mov    0x18(%esi),%edx
  1005a6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005aa:	89 10                	mov    %edx,(%eax)
}
  1005ac:	83 c4 1c             	add    $0x1c,%esp
  1005af:	5b                   	pop    %ebx
  1005b0:	5e                   	pop    %esi
  1005b1:	5f                   	pop    %edi
  1005b2:	5d                   	pop    %ebp
  1005b3:	c3                   	ret    

001005b4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005b4:	56                   	push   %esi
  1005b5:	31 d2                	xor    %edx,%edx
  1005b7:	53                   	push   %ebx
  1005b8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005bc:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005c0:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005c4:	eb 08                	jmp    1005ce <memcpy+0x1a>
		*d++ = *s++;
  1005c6:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005c9:	4e                   	dec    %esi
  1005ca:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005cd:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005ce:	85 f6                	test   %esi,%esi
  1005d0:	75 f4                	jne    1005c6 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005d2:	5b                   	pop    %ebx
  1005d3:	5e                   	pop    %esi
  1005d4:	c3                   	ret    

001005d5 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005d5:	57                   	push   %edi
  1005d6:	56                   	push   %esi
  1005d7:	53                   	push   %ebx
  1005d8:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005dc:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005e0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005e4:	39 c7                	cmp    %eax,%edi
  1005e6:	73 26                	jae    10060e <memmove+0x39>
  1005e8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005eb:	39 c6                	cmp    %eax,%esi
  1005ed:	76 1f                	jbe    10060e <memmove+0x39>
		s += n, d += n;
  1005ef:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005f2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005f4:	eb 07                	jmp    1005fd <memmove+0x28>
			*--d = *--s;
  1005f6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005f9:	4a                   	dec    %edx
  1005fa:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005fd:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005fe:	85 d2                	test   %edx,%edx
  100600:	75 f4                	jne    1005f6 <memmove+0x21>
  100602:	eb 10                	jmp    100614 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100604:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100607:	4a                   	dec    %edx
  100608:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10060b:	41                   	inc    %ecx
  10060c:	eb 02                	jmp    100610 <memmove+0x3b>
  10060e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100610:	85 d2                	test   %edx,%edx
  100612:	75 f0                	jne    100604 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100614:	5b                   	pop    %ebx
  100615:	5e                   	pop    %esi
  100616:	5f                   	pop    %edi
  100617:	c3                   	ret    

00100618 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100618:	53                   	push   %ebx
  100619:	8b 44 24 08          	mov    0x8(%esp),%eax
  10061d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100621:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100625:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100627:	eb 04                	jmp    10062d <memset+0x15>
		*p++ = c;
  100629:	88 1a                	mov    %bl,(%edx)
  10062b:	49                   	dec    %ecx
  10062c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10062d:	85 c9                	test   %ecx,%ecx
  10062f:	75 f8                	jne    100629 <memset+0x11>
		*p++ = c;
	return v;
}
  100631:	5b                   	pop    %ebx
  100632:	c3                   	ret    

00100633 <strlen>:

size_t
strlen(const char *s)
{
  100633:	8b 54 24 04          	mov    0x4(%esp),%edx
  100637:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100639:	eb 01                	jmp    10063c <strlen+0x9>
		++n;
  10063b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10063c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100640:	75 f9                	jne    10063b <strlen+0x8>
		++n;
	return n;
}
  100642:	c3                   	ret    

00100643 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100643:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100647:	31 c0                	xor    %eax,%eax
  100649:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10064d:	eb 01                	jmp    100650 <strnlen+0xd>
		++n;
  10064f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100650:	39 d0                	cmp    %edx,%eax
  100652:	74 06                	je     10065a <strnlen+0x17>
  100654:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100658:	75 f5                	jne    10064f <strnlen+0xc>
		++n;
	return n;
}
  10065a:	c3                   	ret    

0010065b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10065b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10065c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100661:	53                   	push   %ebx
  100662:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100664:	76 05                	jbe    10066b <console_putc+0x10>
  100666:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10066b:	80 fa 0a             	cmp    $0xa,%dl
  10066e:	75 2c                	jne    10069c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100670:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100676:	be 50 00 00 00       	mov    $0x50,%esi
  10067b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10067d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100680:	99                   	cltd   
  100681:	f7 fe                	idiv   %esi
  100683:	89 de                	mov    %ebx,%esi
  100685:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100687:	eb 07                	jmp    100690 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100689:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10068c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10068d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100690:	83 f8 50             	cmp    $0x50,%eax
  100693:	75 f4                	jne    100689 <console_putc+0x2e>
  100695:	29 d0                	sub    %edx,%eax
  100697:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10069a:	eb 0b                	jmp    1006a7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10069c:	0f b6 d2             	movzbl %dl,%edx
  10069f:	09 ca                	or     %ecx,%edx
  1006a1:	66 89 13             	mov    %dx,(%ebx)
  1006a4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006a7:	5b                   	pop    %ebx
  1006a8:	5e                   	pop    %esi
  1006a9:	c3                   	ret    

001006aa <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006aa:	56                   	push   %esi
  1006ab:	53                   	push   %ebx
  1006ac:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006b0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006b3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006b7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006bc:	75 04                	jne    1006c2 <fill_numbuf+0x18>
  1006be:	85 d2                	test   %edx,%edx
  1006c0:	74 10                	je     1006d2 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006c2:	89 d0                	mov    %edx,%eax
  1006c4:	31 d2                	xor    %edx,%edx
  1006c6:	f7 f1                	div    %ecx
  1006c8:	4b                   	dec    %ebx
  1006c9:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006cc:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006ce:	89 c2                	mov    %eax,%edx
  1006d0:	eb ec                	jmp    1006be <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006d2:	89 d8                	mov    %ebx,%eax
  1006d4:	5b                   	pop    %ebx
  1006d5:	5e                   	pop    %esi
  1006d6:	c3                   	ret    

001006d7 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006d7:	55                   	push   %ebp
  1006d8:	57                   	push   %edi
  1006d9:	56                   	push   %esi
  1006da:	53                   	push   %ebx
  1006db:	83 ec 38             	sub    $0x38,%esp
  1006de:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006e2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006e6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006ea:	e9 60 03 00 00       	jmp    100a4f <console_vprintf+0x378>
		if (*format != '%') {
  1006ef:	80 fa 25             	cmp    $0x25,%dl
  1006f2:	74 13                	je     100707 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006f4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006f8:	0f b6 d2             	movzbl %dl,%edx
  1006fb:	89 f0                	mov    %esi,%eax
  1006fd:	e8 59 ff ff ff       	call   10065b <console_putc>
  100702:	e9 45 03 00 00       	jmp    100a4c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100707:	47                   	inc    %edi
  100708:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10070f:	00 
  100710:	eb 12                	jmp    100724 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100712:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100713:	8a 11                	mov    (%ecx),%dl
  100715:	84 d2                	test   %dl,%dl
  100717:	74 1a                	je     100733 <console_vprintf+0x5c>
  100719:	89 e8                	mov    %ebp,%eax
  10071b:	38 c2                	cmp    %al,%dl
  10071d:	75 f3                	jne    100712 <console_vprintf+0x3b>
  10071f:	e9 3f 03 00 00       	jmp    100a63 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100724:	8a 17                	mov    (%edi),%dl
  100726:	84 d2                	test   %dl,%dl
  100728:	74 0b                	je     100735 <console_vprintf+0x5e>
  10072a:	b9 b8 0a 10 00       	mov    $0x100ab8,%ecx
  10072f:	89 d5                	mov    %edx,%ebp
  100731:	eb e0                	jmp    100713 <console_vprintf+0x3c>
  100733:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100735:	8d 42 cf             	lea    -0x31(%edx),%eax
  100738:	3c 08                	cmp    $0x8,%al
  10073a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100741:	00 
  100742:	76 13                	jbe    100757 <console_vprintf+0x80>
  100744:	eb 1d                	jmp    100763 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100746:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10074b:	0f be c0             	movsbl %al,%eax
  10074e:	47                   	inc    %edi
  10074f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100753:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100757:	8a 07                	mov    (%edi),%al
  100759:	8d 50 d0             	lea    -0x30(%eax),%edx
  10075c:	80 fa 09             	cmp    $0x9,%dl
  10075f:	76 e5                	jbe    100746 <console_vprintf+0x6f>
  100761:	eb 18                	jmp    10077b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100763:	80 fa 2a             	cmp    $0x2a,%dl
  100766:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10076d:	ff 
  10076e:	75 0b                	jne    10077b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100770:	83 c3 04             	add    $0x4,%ebx
			++format;
  100773:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100774:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100777:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10077b:	83 cd ff             	or     $0xffffffff,%ebp
  10077e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100781:	75 37                	jne    1007ba <console_vprintf+0xe3>
			++format;
  100783:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100784:	31 ed                	xor    %ebp,%ebp
  100786:	8a 07                	mov    (%edi),%al
  100788:	8d 50 d0             	lea    -0x30(%eax),%edx
  10078b:	80 fa 09             	cmp    $0x9,%dl
  10078e:	76 0d                	jbe    10079d <console_vprintf+0xc6>
  100790:	eb 17                	jmp    1007a9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100792:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100795:	0f be c0             	movsbl %al,%eax
  100798:	47                   	inc    %edi
  100799:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10079d:	8a 07                	mov    (%edi),%al
  10079f:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007a2:	80 fa 09             	cmp    $0x9,%dl
  1007a5:	76 eb                	jbe    100792 <console_vprintf+0xbb>
  1007a7:	eb 11                	jmp    1007ba <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007a9:	3c 2a                	cmp    $0x2a,%al
  1007ab:	75 0b                	jne    1007b8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007ad:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007b0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007b1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007b4:	85 ed                	test   %ebp,%ebp
  1007b6:	79 02                	jns    1007ba <console_vprintf+0xe3>
  1007b8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007ba:	8a 07                	mov    (%edi),%al
  1007bc:	3c 64                	cmp    $0x64,%al
  1007be:	74 34                	je     1007f4 <console_vprintf+0x11d>
  1007c0:	7f 1d                	jg     1007df <console_vprintf+0x108>
  1007c2:	3c 58                	cmp    $0x58,%al
  1007c4:	0f 84 a2 00 00 00    	je     10086c <console_vprintf+0x195>
  1007ca:	3c 63                	cmp    $0x63,%al
  1007cc:	0f 84 bf 00 00 00    	je     100891 <console_vprintf+0x1ba>
  1007d2:	3c 43                	cmp    $0x43,%al
  1007d4:	0f 85 d0 00 00 00    	jne    1008aa <console_vprintf+0x1d3>
  1007da:	e9 a3 00 00 00       	jmp    100882 <console_vprintf+0x1ab>
  1007df:	3c 75                	cmp    $0x75,%al
  1007e1:	74 4d                	je     100830 <console_vprintf+0x159>
  1007e3:	3c 78                	cmp    $0x78,%al
  1007e5:	74 5c                	je     100843 <console_vprintf+0x16c>
  1007e7:	3c 73                	cmp    $0x73,%al
  1007e9:	0f 85 bb 00 00 00    	jne    1008aa <console_vprintf+0x1d3>
  1007ef:	e9 86 00 00 00       	jmp    10087a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007f4:	83 c3 04             	add    $0x4,%ebx
  1007f7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007fa:	89 d1                	mov    %edx,%ecx
  1007fc:	c1 f9 1f             	sar    $0x1f,%ecx
  1007ff:	89 0c 24             	mov    %ecx,(%esp)
  100802:	31 ca                	xor    %ecx,%edx
  100804:	55                   	push   %ebp
  100805:	29 ca                	sub    %ecx,%edx
  100807:	68 c0 0a 10 00       	push   $0x100ac0
  10080c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100811:	8d 44 24 40          	lea    0x40(%esp),%eax
  100815:	e8 90 fe ff ff       	call   1006aa <fill_numbuf>
  10081a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10081e:	58                   	pop    %eax
  10081f:	5a                   	pop    %edx
  100820:	ba 01 00 00 00       	mov    $0x1,%edx
  100825:	8b 04 24             	mov    (%esp),%eax
  100828:	83 e0 01             	and    $0x1,%eax
  10082b:	e9 a5 00 00 00       	jmp    1008d5 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100830:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100833:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100838:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10083b:	55                   	push   %ebp
  10083c:	68 c0 0a 10 00       	push   $0x100ac0
  100841:	eb 11                	jmp    100854 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100843:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100846:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100849:	55                   	push   %ebp
  10084a:	68 d4 0a 10 00       	push   $0x100ad4
  10084f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100854:	8d 44 24 40          	lea    0x40(%esp),%eax
  100858:	e8 4d fe ff ff       	call   1006aa <fill_numbuf>
  10085d:	ba 01 00 00 00       	mov    $0x1,%edx
  100862:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100866:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100868:	59                   	pop    %ecx
  100869:	59                   	pop    %ecx
  10086a:	eb 69                	jmp    1008d5 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10086c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10086f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100872:	55                   	push   %ebp
  100873:	68 c0 0a 10 00       	push   $0x100ac0
  100878:	eb d5                	jmp    10084f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10087a:	83 c3 04             	add    $0x4,%ebx
  10087d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100880:	eb 40                	jmp    1008c2 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100882:	83 c3 04             	add    $0x4,%ebx
  100885:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100888:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10088c:	e9 bd 01 00 00       	jmp    100a4e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100891:	83 c3 04             	add    $0x4,%ebx
  100894:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100897:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10089b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008a0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008a4:	88 44 24 24          	mov    %al,0x24(%esp)
  1008a8:	eb 27                	jmp    1008d1 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008aa:	84 c0                	test   %al,%al
  1008ac:	75 02                	jne    1008b0 <console_vprintf+0x1d9>
  1008ae:	b0 25                	mov    $0x25,%al
  1008b0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008b4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008b9:	80 3f 00             	cmpb   $0x0,(%edi)
  1008bc:	74 0a                	je     1008c8 <console_vprintf+0x1f1>
  1008be:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008c2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008c6:	eb 09                	jmp    1008d1 <console_vprintf+0x1fa>
				format--;
  1008c8:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008cc:	4f                   	dec    %edi
  1008cd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008d1:	31 d2                	xor    %edx,%edx
  1008d3:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008d5:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008d7:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008e1:	74 1f                	je     100902 <console_vprintf+0x22b>
  1008e3:	89 04 24             	mov    %eax,(%esp)
  1008e6:	eb 01                	jmp    1008e9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008e8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008e9:	39 e9                	cmp    %ebp,%ecx
  1008eb:	74 0a                	je     1008f7 <console_vprintf+0x220>
  1008ed:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008f1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008f5:	75 f1                	jne    1008e8 <console_vprintf+0x211>
  1008f7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008fa:	89 0c 24             	mov    %ecx,(%esp)
  1008fd:	eb 1f                	jmp    10091e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008ff:	42                   	inc    %edx
  100900:	eb 09                	jmp    10090b <console_vprintf+0x234>
  100902:	89 d1                	mov    %edx,%ecx
  100904:	8b 14 24             	mov    (%esp),%edx
  100907:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10090b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10090f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100913:	75 ea                	jne    1008ff <console_vprintf+0x228>
  100915:	8b 44 24 08          	mov    0x8(%esp),%eax
  100919:	89 14 24             	mov    %edx,(%esp)
  10091c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10091e:	85 c0                	test   %eax,%eax
  100920:	74 0c                	je     10092e <console_vprintf+0x257>
  100922:	84 d2                	test   %dl,%dl
  100924:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10092b:	00 
  10092c:	75 24                	jne    100952 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10092e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100933:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10093a:	00 
  10093b:	75 15                	jne    100952 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10093d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100941:	83 e0 08             	and    $0x8,%eax
  100944:	83 f8 01             	cmp    $0x1,%eax
  100947:	19 c9                	sbb    %ecx,%ecx
  100949:	f7 d1                	not    %ecx
  10094b:	83 e1 20             	and    $0x20,%ecx
  10094e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100952:	3b 2c 24             	cmp    (%esp),%ebp
  100955:	7e 0d                	jle    100964 <console_vprintf+0x28d>
  100957:	84 d2                	test   %dl,%dl
  100959:	74 40                	je     10099b <console_vprintf+0x2c4>
			zeros = precision - len;
  10095b:	2b 2c 24             	sub    (%esp),%ebp
  10095e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100962:	eb 3f                	jmp    1009a3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100964:	84 d2                	test   %dl,%dl
  100966:	74 33                	je     10099b <console_vprintf+0x2c4>
  100968:	8b 44 24 14          	mov    0x14(%esp),%eax
  10096c:	83 e0 06             	and    $0x6,%eax
  10096f:	83 f8 02             	cmp    $0x2,%eax
  100972:	75 27                	jne    10099b <console_vprintf+0x2c4>
  100974:	45                   	inc    %ebp
  100975:	75 24                	jne    10099b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100977:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100979:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  10097c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100981:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100984:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100987:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10098b:	7d 0e                	jge    10099b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  10098d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100991:	29 ca                	sub    %ecx,%edx
  100993:	29 c2                	sub    %eax,%edx
  100995:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100999:	eb 08                	jmp    1009a3 <console_vprintf+0x2cc>
  10099b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009a2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009a3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009a7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009ad:	2b 2c 24             	sub    (%esp),%ebp
  1009b0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009bb:	29 c5                	sub    %eax,%ebp
  1009bd:	89 f0                	mov    %esi,%eax
  1009bf:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009c7:	eb 0f                	jmp    1009d8 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009c9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009cd:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009d2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009d3:	e8 83 fc ff ff       	call   10065b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009d8:	85 ed                	test   %ebp,%ebp
  1009da:	7e 07                	jle    1009e3 <console_vprintf+0x30c>
  1009dc:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009e1:	74 e6                	je     1009c9 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009e3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009e8:	89 c6                	mov    %eax,%esi
  1009ea:	74 23                	je     100a0f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009ec:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009f1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009f5:	e8 61 fc ff ff       	call   10065b <console_putc>
  1009fa:	89 c6                	mov    %eax,%esi
  1009fc:	eb 11                	jmp    100a0f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009fe:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a02:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a07:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a08:	e8 4e fc ff ff       	call   10065b <console_putc>
  100a0d:	eb 06                	jmp    100a15 <console_vprintf+0x33e>
  100a0f:	89 f0                	mov    %esi,%eax
  100a11:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a15:	85 f6                	test   %esi,%esi
  100a17:	7f e5                	jg     1009fe <console_vprintf+0x327>
  100a19:	8b 34 24             	mov    (%esp),%esi
  100a1c:	eb 15                	jmp    100a33 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a1e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a22:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a23:	0f b6 11             	movzbl (%ecx),%edx
  100a26:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a2a:	e8 2c fc ff ff       	call   10065b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a2f:	ff 44 24 04          	incl   0x4(%esp)
  100a33:	85 f6                	test   %esi,%esi
  100a35:	7f e7                	jg     100a1e <console_vprintf+0x347>
  100a37:	eb 0f                	jmp    100a48 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a39:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a3d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a42:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a43:	e8 13 fc ff ff       	call   10065b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a48:	85 ed                	test   %ebp,%ebp
  100a4a:	7f ed                	jg     100a39 <console_vprintf+0x362>
  100a4c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a4e:	47                   	inc    %edi
  100a4f:	8a 17                	mov    (%edi),%dl
  100a51:	84 d2                	test   %dl,%dl
  100a53:	0f 85 96 fc ff ff    	jne    1006ef <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a59:	83 c4 38             	add    $0x38,%esp
  100a5c:	89 f0                	mov    %esi,%eax
  100a5e:	5b                   	pop    %ebx
  100a5f:	5e                   	pop    %esi
  100a60:	5f                   	pop    %edi
  100a61:	5d                   	pop    %ebp
  100a62:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a63:	81 e9 b8 0a 10 00    	sub    $0x100ab8,%ecx
  100a69:	b8 01 00 00 00       	mov    $0x1,%eax
  100a6e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a70:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a71:	09 44 24 14          	or     %eax,0x14(%esp)
  100a75:	e9 aa fc ff ff       	jmp    100724 <console_vprintf+0x4d>

00100a7a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a7a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a7e:	50                   	push   %eax
  100a7f:	ff 74 24 10          	pushl  0x10(%esp)
  100a83:	ff 74 24 10          	pushl  0x10(%esp)
  100a87:	ff 74 24 10          	pushl  0x10(%esp)
  100a8b:	e8 47 fc ff ff       	call   1006d7 <console_vprintf>
  100a90:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a93:	c3                   	ret    
