
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
  100014:	e8 4d 01 00 00       	call   100166 <start>
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
  10008f:	a1 38 9e 10 00       	mov    0x109e38,%eax
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
  1000a1:	6b c2 50             	imul   $0x50,%edx,%eax
  1000a4:	83 b8 18 91 10 00 01 	cmpl   $0x1,0x109118(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 d0 90 10 00       	add    $0x1090d0,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 c5 02 00 00       	call   100380 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	57                   	push   %edi
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
  1000c1:	56                   	push   %esi
  1000c2:	83 ec 04             	sub    $0x4,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c5:	a1 38 9e 10 00       	mov    0x109e38,%eax

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000ca:	8b 54 24 10          	mov    0x10(%esp),%edx
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000ce:	8d 78 04             	lea    0x4(%eax),%edi
  1000d1:	89 d6                	mov    %edx,%esi
  1000d3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d5:	8b 52 28             	mov    0x28(%edx),%edx
  1000d8:	83 ea 30             	sub    $0x30,%edx
  1000db:	83 fa 04             	cmp    $0x4,%edx
  1000de:	0f 87 80 00 00 00    	ja     100164 <interrupt+0xa9>
  1000e4:	ff 24 95 38 09 10 00 	jmp    *0x100938(,%edx,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000eb:	8b 10                	mov    (%eax),%edx
  1000ed:	89 50 20             	mov    %edx,0x20(%eax)
  1000f0:	eb 07                	jmp    1000f9 <interrupt+0x3e>
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  1000f2:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		run(current);
  1000f9:	83 ec 0c             	sub    $0xc,%esp
  1000fc:	50                   	push   %eax
  1000fd:	e8 7e 02 00 00       	call   100380 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  100102:	e8 85 ff ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  100107:	a1 38 9e 10 00       	mov    0x109e38,%eax
		current->p_exit_status = current->p_registers.reg_eax;
  10010c:	8b 50 20             	mov    0x20(%eax),%edx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  10010f:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
  100116:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100119:	e8 6e ff ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  10011e:	a1 38 9e 10 00       	mov    0x109e38,%eax
  100123:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100126:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100129:	83 f9 0e             	cmp    $0xe,%ecx
  10012c:	77 11                	ja     10013f <interrupt+0x84>
  10012e:	3b 10                	cmp    (%eax),%edx
  100130:	74 0d                	je     10013f <interrupt+0x84>
		    || proc_array[p].p_state == P_EMPTY)
  100132:	6b d2 50             	imul   $0x50,%edx,%edx
  100135:	8b 8a 18 91 10 00    	mov    0x109118(%edx),%ecx
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  10013b:	85 c9                	test   %ecx,%ecx
  10013d:	75 09                	jne    100148 <interrupt+0x8d>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  10013f:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100146:	eb 17                	jmp    10015f <interrupt+0xa4>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  100148:	83 f9 03             	cmp    $0x3,%ecx
  10014b:	75 0b                	jne    100158 <interrupt+0x9d>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  10014d:	8b 92 1c 91 10 00    	mov    0x10911c(%edx),%edx
  100153:	89 50 20             	mov    %edx,0x20(%eax)
  100156:	eb 07                	jmp    10015f <interrupt+0xa4>
		else
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
  100158:	c7 40 20 fe ff ff ff 	movl   $0xfffffffe,0x20(%eax)
		schedule();
  10015f:	e8 28 ff ff ff       	call   10008c <schedule>
  100164:	eb fe                	jmp    100164 <interrupt+0xa9>

00100166 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100166:	53                   	push   %ebx
  100167:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10016a:	68 00 05 00 00       	push   $0x500
  10016f:	6a 00                	push   $0x0
  100171:	68 d0 90 10 00       	push   $0x1090d0
  100176:	e8 41 03 00 00       	call   1004bc <memset>
  10017b:	ba d0 90 10 00       	mov    $0x1090d0,%edx
  100180:	31 c0                	xor    %eax,%eax
  100182:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100185:	89 02                	mov    %eax,(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100187:	40                   	inc    %eax
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100188:	c7 42 48 00 00 00 00 	movl   $0x0,0x48(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10018f:	83 c2 50             	add    $0x50,%edx
  100192:	83 f8 10             	cmp    $0x10,%eax
  100195:	75 ee                	jne    100185 <start+0x1f>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100197:	c7 05 38 9e 10 00 20 	movl   $0x109120,0x109e38
  10019e:	91 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  1001a1:	e8 72 00 00 00       	call   100218 <segments_init>
	special_registers_init(current);
  1001a6:	83 ec 0c             	sub    $0xc,%esp
  1001a9:	ff 35 38 9e 10 00    	pushl  0x109e38
  1001af:	e8 e3 01 00 00       	call   100397 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  1001b4:	e8 2e 01 00 00       	call   1002e7 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  1001b9:	83 c4 0c             	add    $0xc,%esp
  1001bc:	68 4c 09 10 00       	push   $0x10094c
  1001c1:	68 00 07 00 00       	push   $0x700
  1001c6:	ff 35 00 00 06 00    	pushl  0x60000
  1001cc:	e8 4d 07 00 00       	call   10091e <console_printf>
  1001d1:	83 c4 10             	add    $0x10,%esp
  1001d4:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1001d9:	e8 4c 01 00 00       	call   10032a <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1001de:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1001e1:	83 fb 01             	cmp    $0x1,%ebx
  1001e4:	77 f3                	ja     1001d9 <start+0x73>
	console_clear();
  1001e6:	e8 fc 00 00 00       	call   1002e7 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1001eb:	50                   	push   %eax
  1001ec:	50                   	push   %eax
  1001ed:	a1 38 9e 10 00       	mov    0x109e38,%eax
  1001f2:	83 c0 34             	add    $0x34,%eax
  1001f5:	50                   	push   %eax
  1001f6:	53                   	push   %ebx
  1001f7:	e8 d0 01 00 00       	call   1003cc <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1001fc:	a1 38 9e 10 00       	mov    0x109e38,%eax
  100201:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  100208:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  10020f:	89 04 24             	mov    %eax,(%esp)
  100212:	e8 69 01 00 00       	call   100380 <run>
  100217:	90                   	nop

00100218 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100218:	b8 d0 95 10 00       	mov    $0x1095d0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10021d:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100222:	89 c2                	mov    %eax,%edx
  100224:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100227:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100228:	bb 56 00 10 00       	mov    $0x100056,%ebx
  10022d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100230:	66 a3 ea 19 10 00    	mov    %ax,0x1019ea
  100236:	c1 e8 18             	shr    $0x18,%eax
  100239:	88 15 ec 19 10 00    	mov    %dl,0x1019ec
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10023f:	ba 38 96 10 00       	mov    $0x109638,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100244:	a2 ef 19 10 00       	mov    %al,0x1019ef
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100249:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10024b:	66 c7 05 e8 19 10 00 	movw   $0x68,0x1019e8
  100252:	68 00 
  100254:	c6 05 ee 19 10 00 40 	movb   $0x40,0x1019ee
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10025b:	c6 05 ed 19 10 00 89 	movb   $0x89,0x1019ed

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100262:	c7 05 d4 95 10 00 00 	movl   $0x80000,0x1095d4
  100269:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10026c:	66 c7 05 d8 95 10 00 	movw   $0x10,0x1095d8
  100273:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100275:	66 89 0c c5 38 96 10 	mov    %cx,0x109638(,%eax,8)
  10027c:	00 
  10027d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100284:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100289:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10028e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100293:	40                   	inc    %eax
  100294:	3d 00 01 00 00       	cmp    $0x100,%eax
  100299:	75 da                	jne    100275 <segments_init+0x5d>
  10029b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10029f:	ba 38 96 10 00       	mov    $0x109638,%edx
  1002a4:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  1002ab:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002b2:	66 89 0c c5 38 96 10 	mov    %cx,0x109638(,%eax,8)
  1002b9:	00 
  1002ba:	c1 e9 10             	shr    $0x10,%ecx
  1002bd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1002c2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1002c7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  1002cc:	40                   	inc    %eax
  1002cd:	83 f8 3a             	cmp    $0x3a,%eax
  1002d0:	75 d2                	jne    1002a4 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1002d2:	b0 28                	mov    $0x28,%al
  1002d4:	0f 01 15 b0 19 10 00 	lgdtl  0x1019b0
  1002db:	0f 00 d8             	ltr    %ax
  1002de:	0f 01 1d b8 19 10 00 	lidtl  0x1019b8
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1002e5:	5b                   	pop    %ebx
  1002e6:	c3                   	ret    

001002e7 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1002e7:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1002e8:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1002ea:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1002eb:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1002f2:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1002f5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1002fc:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1002ff:	40                   	inc    %eax
  100300:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100305:	75 ee                	jne    1002f5 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100307:	be d4 03 00 00       	mov    $0x3d4,%esi
  10030c:	b0 0e                	mov    $0xe,%al
  10030e:	89 f2                	mov    %esi,%edx
  100310:	ee                   	out    %al,(%dx)
  100311:	31 c9                	xor    %ecx,%ecx
  100313:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100318:	88 c8                	mov    %cl,%al
  10031a:	89 da                	mov    %ebx,%edx
  10031c:	ee                   	out    %al,(%dx)
  10031d:	b0 0f                	mov    $0xf,%al
  10031f:	89 f2                	mov    %esi,%edx
  100321:	ee                   	out    %al,(%dx)
  100322:	88 c8                	mov    %cl,%al
  100324:	89 da                	mov    %ebx,%edx
  100326:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100327:	5b                   	pop    %ebx
  100328:	5e                   	pop    %esi
  100329:	c3                   	ret    

0010032a <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10032a:	ba 64 00 00 00       	mov    $0x64,%edx
  10032f:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100330:	a8 01                	test   $0x1,%al
  100332:	74 45                	je     100379 <console_read_digit+0x4f>
  100334:	b2 60                	mov    $0x60,%dl
  100336:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100337:	8d 50 fe             	lea    -0x2(%eax),%edx
  10033a:	80 fa 08             	cmp    $0x8,%dl
  10033d:	77 05                	ja     100344 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10033f:	0f b6 c0             	movzbl %al,%eax
  100342:	48                   	dec    %eax
  100343:	c3                   	ret    
	else if (data == 0x0B)
  100344:	3c 0b                	cmp    $0xb,%al
  100346:	74 35                	je     10037d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100348:	8d 50 b9             	lea    -0x47(%eax),%edx
  10034b:	80 fa 02             	cmp    $0x2,%dl
  10034e:	77 07                	ja     100357 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100350:	0f b6 c0             	movzbl %al,%eax
  100353:	83 e8 40             	sub    $0x40,%eax
  100356:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100357:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10035a:	80 fa 02             	cmp    $0x2,%dl
  10035d:	77 07                	ja     100366 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10035f:	0f b6 c0             	movzbl %al,%eax
  100362:	83 e8 47             	sub    $0x47,%eax
  100365:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100366:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100369:	80 fa 02             	cmp    $0x2,%dl
  10036c:	77 07                	ja     100375 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10036e:	0f b6 c0             	movzbl %al,%eax
  100371:	83 e8 4e             	sub    $0x4e,%eax
  100374:	c3                   	ret    
	else if (data == 0x53)
  100375:	3c 53                	cmp    $0x53,%al
  100377:	74 04                	je     10037d <console_read_digit+0x53>
  100379:	83 c8 ff             	or     $0xffffffff,%eax
  10037c:	c3                   	ret    
  10037d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10037f:	c3                   	ret    

00100380 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100380:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100384:	a3 38 9e 10 00       	mov    %eax,0x109e38

	asm volatile("movl %0,%%esp\n\t"
  100389:	83 c0 04             	add    $0x4,%eax
  10038c:	89 c4                	mov    %eax,%esp
  10038e:	61                   	popa   
  10038f:	07                   	pop    %es
  100390:	1f                   	pop    %ds
  100391:	83 c4 08             	add    $0x8,%esp
  100394:	cf                   	iret   
  100395:	eb fe                	jmp    100395 <run+0x15>

00100397 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100397:	53                   	push   %ebx
  100398:	83 ec 0c             	sub    $0xc,%esp
  10039b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10039f:	6a 44                	push   $0x44
  1003a1:	6a 00                	push   $0x0
  1003a3:	8d 43 04             	lea    0x4(%ebx),%eax
  1003a6:	50                   	push   %eax
  1003a7:	e8 10 01 00 00       	call   1004bc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1003ac:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1003b2:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1003b8:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1003be:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  1003c4:	83 c4 18             	add    $0x18,%esp
  1003c7:	5b                   	pop    %ebx
  1003c8:	c3                   	ret    
  1003c9:	90                   	nop
  1003ca:	90                   	nop
  1003cb:	90                   	nop

001003cc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1003cc:	55                   	push   %ebp
  1003cd:	57                   	push   %edi
  1003ce:	56                   	push   %esi
  1003cf:	53                   	push   %ebx
  1003d0:	83 ec 1c             	sub    $0x1c,%esp
  1003d3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1003d7:	83 f8 01             	cmp    $0x1,%eax
  1003da:	7f 04                	jg     1003e0 <program_loader+0x14>
  1003dc:	85 c0                	test   %eax,%eax
  1003de:	79 02                	jns    1003e2 <program_loader+0x16>
  1003e0:	eb fe                	jmp    1003e0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1003e2:	8b 34 c5 f0 19 10 00 	mov    0x1019f0(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1003e9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1003ef:	74 02                	je     1003f3 <program_loader+0x27>
  1003f1:	eb fe                	jmp    1003f1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1003f3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1003f6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1003fa:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1003fc:	c1 e5 05             	shl    $0x5,%ebp
  1003ff:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100402:	eb 3f                	jmp    100443 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100404:	83 3b 01             	cmpl   $0x1,(%ebx)
  100407:	75 37                	jne    100440 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100409:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10040c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10040f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100412:	01 c7                	add    %eax,%edi
	memsz += va;
  100414:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100416:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10041b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10041f:	52                   	push   %edx
  100420:	89 fa                	mov    %edi,%edx
  100422:	29 c2                	sub    %eax,%edx
  100424:	52                   	push   %edx
  100425:	8b 53 04             	mov    0x4(%ebx),%edx
  100428:	01 f2                	add    %esi,%edx
  10042a:	52                   	push   %edx
  10042b:	50                   	push   %eax
  10042c:	e8 27 00 00 00       	call   100458 <memcpy>
  100431:	83 c4 10             	add    $0x10,%esp
  100434:	eb 04                	jmp    10043a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100436:	c6 07 00             	movb   $0x0,(%edi)
  100439:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10043a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10043e:	72 f6                	jb     100436 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100440:	83 c3 20             	add    $0x20,%ebx
  100443:	39 eb                	cmp    %ebp,%ebx
  100445:	72 bd                	jb     100404 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100447:	8b 56 18             	mov    0x18(%esi),%edx
  10044a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10044e:	89 10                	mov    %edx,(%eax)
}
  100450:	83 c4 1c             	add    $0x1c,%esp
  100453:	5b                   	pop    %ebx
  100454:	5e                   	pop    %esi
  100455:	5f                   	pop    %edi
  100456:	5d                   	pop    %ebp
  100457:	c3                   	ret    

00100458 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100458:	56                   	push   %esi
  100459:	31 d2                	xor    %edx,%edx
  10045b:	53                   	push   %ebx
  10045c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100460:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100464:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100468:	eb 08                	jmp    100472 <memcpy+0x1a>
		*d++ = *s++;
  10046a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10046d:	4e                   	dec    %esi
  10046e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100471:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100472:	85 f6                	test   %esi,%esi
  100474:	75 f4                	jne    10046a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100476:	5b                   	pop    %ebx
  100477:	5e                   	pop    %esi
  100478:	c3                   	ret    

00100479 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100479:	57                   	push   %edi
  10047a:	56                   	push   %esi
  10047b:	53                   	push   %ebx
  10047c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100480:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100484:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100488:	39 c7                	cmp    %eax,%edi
  10048a:	73 26                	jae    1004b2 <memmove+0x39>
  10048c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10048f:	39 c6                	cmp    %eax,%esi
  100491:	76 1f                	jbe    1004b2 <memmove+0x39>
		s += n, d += n;
  100493:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100496:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100498:	eb 07                	jmp    1004a1 <memmove+0x28>
			*--d = *--s;
  10049a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10049d:	4a                   	dec    %edx
  10049e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1004a1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1004a2:	85 d2                	test   %edx,%edx
  1004a4:	75 f4                	jne    10049a <memmove+0x21>
  1004a6:	eb 10                	jmp    1004b8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1004a8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1004ab:	4a                   	dec    %edx
  1004ac:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1004af:	41                   	inc    %ecx
  1004b0:	eb 02                	jmp    1004b4 <memmove+0x3b>
  1004b2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1004b4:	85 d2                	test   %edx,%edx
  1004b6:	75 f0                	jne    1004a8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1004b8:	5b                   	pop    %ebx
  1004b9:	5e                   	pop    %esi
  1004ba:	5f                   	pop    %edi
  1004bb:	c3                   	ret    

001004bc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1004bc:	53                   	push   %ebx
  1004bd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1004c1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1004c5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1004c9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1004cb:	eb 04                	jmp    1004d1 <memset+0x15>
		*p++ = c;
  1004cd:	88 1a                	mov    %bl,(%edx)
  1004cf:	49                   	dec    %ecx
  1004d0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1004d1:	85 c9                	test   %ecx,%ecx
  1004d3:	75 f8                	jne    1004cd <memset+0x11>
		*p++ = c;
	return v;
}
  1004d5:	5b                   	pop    %ebx
  1004d6:	c3                   	ret    

001004d7 <strlen>:

size_t
strlen(const char *s)
{
  1004d7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1004db:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1004dd:	eb 01                	jmp    1004e0 <strlen+0x9>
		++n;
  1004df:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1004e0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1004e4:	75 f9                	jne    1004df <strlen+0x8>
		++n;
	return n;
}
  1004e6:	c3                   	ret    

001004e7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1004e7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1004eb:	31 c0                	xor    %eax,%eax
  1004ed:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1004f1:	eb 01                	jmp    1004f4 <strnlen+0xd>
		++n;
  1004f3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1004f4:	39 d0                	cmp    %edx,%eax
  1004f6:	74 06                	je     1004fe <strnlen+0x17>
  1004f8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1004fc:	75 f5                	jne    1004f3 <strnlen+0xc>
		++n;
	return n;
}
  1004fe:	c3                   	ret    

001004ff <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1004ff:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100500:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100505:	53                   	push   %ebx
  100506:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100508:	76 05                	jbe    10050f <console_putc+0x10>
  10050a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10050f:	80 fa 0a             	cmp    $0xa,%dl
  100512:	75 2c                	jne    100540 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100514:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10051a:	be 50 00 00 00       	mov    $0x50,%esi
  10051f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100521:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100524:	99                   	cltd   
  100525:	f7 fe                	idiv   %esi
  100527:	89 de                	mov    %ebx,%esi
  100529:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10052b:	eb 07                	jmp    100534 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10052d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100530:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100531:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100534:	83 f8 50             	cmp    $0x50,%eax
  100537:	75 f4                	jne    10052d <console_putc+0x2e>
  100539:	29 d0                	sub    %edx,%eax
  10053b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10053e:	eb 0b                	jmp    10054b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100540:	0f b6 d2             	movzbl %dl,%edx
  100543:	09 ca                	or     %ecx,%edx
  100545:	66 89 13             	mov    %dx,(%ebx)
  100548:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10054b:	5b                   	pop    %ebx
  10054c:	5e                   	pop    %esi
  10054d:	c3                   	ret    

0010054e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10054e:	56                   	push   %esi
  10054f:	53                   	push   %ebx
  100550:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100554:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100557:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10055b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100560:	75 04                	jne    100566 <fill_numbuf+0x18>
  100562:	85 d2                	test   %edx,%edx
  100564:	74 10                	je     100576 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100566:	89 d0                	mov    %edx,%eax
  100568:	31 d2                	xor    %edx,%edx
  10056a:	f7 f1                	div    %ecx
  10056c:	4b                   	dec    %ebx
  10056d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100570:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100572:	89 c2                	mov    %eax,%edx
  100574:	eb ec                	jmp    100562 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100576:	89 d8                	mov    %ebx,%eax
  100578:	5b                   	pop    %ebx
  100579:	5e                   	pop    %esi
  10057a:	c3                   	ret    

0010057b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10057b:	55                   	push   %ebp
  10057c:	57                   	push   %edi
  10057d:	56                   	push   %esi
  10057e:	53                   	push   %ebx
  10057f:	83 ec 38             	sub    $0x38,%esp
  100582:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100586:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10058a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10058e:	e9 60 03 00 00       	jmp    1008f3 <console_vprintf+0x378>
		if (*format != '%') {
  100593:	80 fa 25             	cmp    $0x25,%dl
  100596:	74 13                	je     1005ab <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100598:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10059c:	0f b6 d2             	movzbl %dl,%edx
  10059f:	89 f0                	mov    %esi,%eax
  1005a1:	e8 59 ff ff ff       	call   1004ff <console_putc>
  1005a6:	e9 45 03 00 00       	jmp    1008f0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1005ab:	47                   	inc    %edi
  1005ac:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1005b3:	00 
  1005b4:	eb 12                	jmp    1005c8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1005b6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1005b7:	8a 11                	mov    (%ecx),%dl
  1005b9:	84 d2                	test   %dl,%dl
  1005bb:	74 1a                	je     1005d7 <console_vprintf+0x5c>
  1005bd:	89 e8                	mov    %ebp,%eax
  1005bf:	38 c2                	cmp    %al,%dl
  1005c1:	75 f3                	jne    1005b6 <console_vprintf+0x3b>
  1005c3:	e9 3f 03 00 00       	jmp    100907 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1005c8:	8a 17                	mov    (%edi),%dl
  1005ca:	84 d2                	test   %dl,%dl
  1005cc:	74 0b                	je     1005d9 <console_vprintf+0x5e>
  1005ce:	b9 80 09 10 00       	mov    $0x100980,%ecx
  1005d3:	89 d5                	mov    %edx,%ebp
  1005d5:	eb e0                	jmp    1005b7 <console_vprintf+0x3c>
  1005d7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1005d9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1005dc:	3c 08                	cmp    $0x8,%al
  1005de:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1005e5:	00 
  1005e6:	76 13                	jbe    1005fb <console_vprintf+0x80>
  1005e8:	eb 1d                	jmp    100607 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1005ea:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1005ef:	0f be c0             	movsbl %al,%eax
  1005f2:	47                   	inc    %edi
  1005f3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1005f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1005fb:	8a 07                	mov    (%edi),%al
  1005fd:	8d 50 d0             	lea    -0x30(%eax),%edx
  100600:	80 fa 09             	cmp    $0x9,%dl
  100603:	76 e5                	jbe    1005ea <console_vprintf+0x6f>
  100605:	eb 18                	jmp    10061f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100607:	80 fa 2a             	cmp    $0x2a,%dl
  10060a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100611:	ff 
  100612:	75 0b                	jne    10061f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100614:	83 c3 04             	add    $0x4,%ebx
			++format;
  100617:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100618:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10061b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10061f:	83 cd ff             	or     $0xffffffff,%ebp
  100622:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100625:	75 37                	jne    10065e <console_vprintf+0xe3>
			++format;
  100627:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100628:	31 ed                	xor    %ebp,%ebp
  10062a:	8a 07                	mov    (%edi),%al
  10062c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10062f:	80 fa 09             	cmp    $0x9,%dl
  100632:	76 0d                	jbe    100641 <console_vprintf+0xc6>
  100634:	eb 17                	jmp    10064d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100636:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100639:	0f be c0             	movsbl %al,%eax
  10063c:	47                   	inc    %edi
  10063d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100641:	8a 07                	mov    (%edi),%al
  100643:	8d 50 d0             	lea    -0x30(%eax),%edx
  100646:	80 fa 09             	cmp    $0x9,%dl
  100649:	76 eb                	jbe    100636 <console_vprintf+0xbb>
  10064b:	eb 11                	jmp    10065e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10064d:	3c 2a                	cmp    $0x2a,%al
  10064f:	75 0b                	jne    10065c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100651:	83 c3 04             	add    $0x4,%ebx
				++format;
  100654:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100655:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100658:	85 ed                	test   %ebp,%ebp
  10065a:	79 02                	jns    10065e <console_vprintf+0xe3>
  10065c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10065e:	8a 07                	mov    (%edi),%al
  100660:	3c 64                	cmp    $0x64,%al
  100662:	74 34                	je     100698 <console_vprintf+0x11d>
  100664:	7f 1d                	jg     100683 <console_vprintf+0x108>
  100666:	3c 58                	cmp    $0x58,%al
  100668:	0f 84 a2 00 00 00    	je     100710 <console_vprintf+0x195>
  10066e:	3c 63                	cmp    $0x63,%al
  100670:	0f 84 bf 00 00 00    	je     100735 <console_vprintf+0x1ba>
  100676:	3c 43                	cmp    $0x43,%al
  100678:	0f 85 d0 00 00 00    	jne    10074e <console_vprintf+0x1d3>
  10067e:	e9 a3 00 00 00       	jmp    100726 <console_vprintf+0x1ab>
  100683:	3c 75                	cmp    $0x75,%al
  100685:	74 4d                	je     1006d4 <console_vprintf+0x159>
  100687:	3c 78                	cmp    $0x78,%al
  100689:	74 5c                	je     1006e7 <console_vprintf+0x16c>
  10068b:	3c 73                	cmp    $0x73,%al
  10068d:	0f 85 bb 00 00 00    	jne    10074e <console_vprintf+0x1d3>
  100693:	e9 86 00 00 00       	jmp    10071e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100698:	83 c3 04             	add    $0x4,%ebx
  10069b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10069e:	89 d1                	mov    %edx,%ecx
  1006a0:	c1 f9 1f             	sar    $0x1f,%ecx
  1006a3:	89 0c 24             	mov    %ecx,(%esp)
  1006a6:	31 ca                	xor    %ecx,%edx
  1006a8:	55                   	push   %ebp
  1006a9:	29 ca                	sub    %ecx,%edx
  1006ab:	68 88 09 10 00       	push   $0x100988
  1006b0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1006b5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1006b9:	e8 90 fe ff ff       	call   10054e <fill_numbuf>
  1006be:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1006c2:	58                   	pop    %eax
  1006c3:	5a                   	pop    %edx
  1006c4:	ba 01 00 00 00       	mov    $0x1,%edx
  1006c9:	8b 04 24             	mov    (%esp),%eax
  1006cc:	83 e0 01             	and    $0x1,%eax
  1006cf:	e9 a5 00 00 00       	jmp    100779 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1006d4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1006d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1006dc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006df:	55                   	push   %ebp
  1006e0:	68 88 09 10 00       	push   $0x100988
  1006e5:	eb 11                	jmp    1006f8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1006e7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1006ea:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006ed:	55                   	push   %ebp
  1006ee:	68 9c 09 10 00       	push   $0x10099c
  1006f3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1006f8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1006fc:	e8 4d fe ff ff       	call   10054e <fill_numbuf>
  100701:	ba 01 00 00 00       	mov    $0x1,%edx
  100706:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10070a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10070c:	59                   	pop    %ecx
  10070d:	59                   	pop    %ecx
  10070e:	eb 69                	jmp    100779 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100710:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100713:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100716:	55                   	push   %ebp
  100717:	68 88 09 10 00       	push   $0x100988
  10071c:	eb d5                	jmp    1006f3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10071e:	83 c3 04             	add    $0x4,%ebx
  100721:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100724:	eb 40                	jmp    100766 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100726:	83 c3 04             	add    $0x4,%ebx
  100729:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10072c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100730:	e9 bd 01 00 00       	jmp    1008f2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100735:	83 c3 04             	add    $0x4,%ebx
  100738:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10073b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10073f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100744:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100748:	88 44 24 24          	mov    %al,0x24(%esp)
  10074c:	eb 27                	jmp    100775 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10074e:	84 c0                	test   %al,%al
  100750:	75 02                	jne    100754 <console_vprintf+0x1d9>
  100752:	b0 25                	mov    $0x25,%al
  100754:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100758:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10075d:	80 3f 00             	cmpb   $0x0,(%edi)
  100760:	74 0a                	je     10076c <console_vprintf+0x1f1>
  100762:	8d 44 24 24          	lea    0x24(%esp),%eax
  100766:	89 44 24 04          	mov    %eax,0x4(%esp)
  10076a:	eb 09                	jmp    100775 <console_vprintf+0x1fa>
				format--;
  10076c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100770:	4f                   	dec    %edi
  100771:	89 54 24 04          	mov    %edx,0x4(%esp)
  100775:	31 d2                	xor    %edx,%edx
  100777:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100779:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10077b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10077e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100785:	74 1f                	je     1007a6 <console_vprintf+0x22b>
  100787:	89 04 24             	mov    %eax,(%esp)
  10078a:	eb 01                	jmp    10078d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10078c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10078d:	39 e9                	cmp    %ebp,%ecx
  10078f:	74 0a                	je     10079b <console_vprintf+0x220>
  100791:	8b 44 24 04          	mov    0x4(%esp),%eax
  100795:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100799:	75 f1                	jne    10078c <console_vprintf+0x211>
  10079b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10079e:	89 0c 24             	mov    %ecx,(%esp)
  1007a1:	eb 1f                	jmp    1007c2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1007a3:	42                   	inc    %edx
  1007a4:	eb 09                	jmp    1007af <console_vprintf+0x234>
  1007a6:	89 d1                	mov    %edx,%ecx
  1007a8:	8b 14 24             	mov    (%esp),%edx
  1007ab:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007af:	8b 44 24 04          	mov    0x4(%esp),%eax
  1007b3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1007b7:	75 ea                	jne    1007a3 <console_vprintf+0x228>
  1007b9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007bd:	89 14 24             	mov    %edx,(%esp)
  1007c0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1007c2:	85 c0                	test   %eax,%eax
  1007c4:	74 0c                	je     1007d2 <console_vprintf+0x257>
  1007c6:	84 d2                	test   %dl,%dl
  1007c8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1007cf:	00 
  1007d0:	75 24                	jne    1007f6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1007d2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1007d7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1007de:	00 
  1007df:	75 15                	jne    1007f6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1007e1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1007e5:	83 e0 08             	and    $0x8,%eax
  1007e8:	83 f8 01             	cmp    $0x1,%eax
  1007eb:	19 c9                	sbb    %ecx,%ecx
  1007ed:	f7 d1                	not    %ecx
  1007ef:	83 e1 20             	and    $0x20,%ecx
  1007f2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1007f6:	3b 2c 24             	cmp    (%esp),%ebp
  1007f9:	7e 0d                	jle    100808 <console_vprintf+0x28d>
  1007fb:	84 d2                	test   %dl,%dl
  1007fd:	74 40                	je     10083f <console_vprintf+0x2c4>
			zeros = precision - len;
  1007ff:	2b 2c 24             	sub    (%esp),%ebp
  100802:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100806:	eb 3f                	jmp    100847 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100808:	84 d2                	test   %dl,%dl
  10080a:	74 33                	je     10083f <console_vprintf+0x2c4>
  10080c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100810:	83 e0 06             	and    $0x6,%eax
  100813:	83 f8 02             	cmp    $0x2,%eax
  100816:	75 27                	jne    10083f <console_vprintf+0x2c4>
  100818:	45                   	inc    %ebp
  100819:	75 24                	jne    10083f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10081b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10081d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100820:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100825:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100828:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10082b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10082f:	7d 0e                	jge    10083f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100831:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100835:	29 ca                	sub    %ecx,%edx
  100837:	29 c2                	sub    %eax,%edx
  100839:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10083d:	eb 08                	jmp    100847 <console_vprintf+0x2cc>
  10083f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100846:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100847:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10084b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10084d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100851:	2b 2c 24             	sub    (%esp),%ebp
  100854:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100859:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10085c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10085f:	29 c5                	sub    %eax,%ebp
  100861:	89 f0                	mov    %esi,%eax
  100863:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100867:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10086b:	eb 0f                	jmp    10087c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  10086d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100871:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100876:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100877:	e8 83 fc ff ff       	call   1004ff <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10087c:	85 ed                	test   %ebp,%ebp
  10087e:	7e 07                	jle    100887 <console_vprintf+0x30c>
  100880:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100885:	74 e6                	je     10086d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100887:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10088c:	89 c6                	mov    %eax,%esi
  10088e:	74 23                	je     1008b3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100890:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100895:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100899:	e8 61 fc ff ff       	call   1004ff <console_putc>
  10089e:	89 c6                	mov    %eax,%esi
  1008a0:	eb 11                	jmp    1008b3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1008a2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008a6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1008ab:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1008ac:	e8 4e fc ff ff       	call   1004ff <console_putc>
  1008b1:	eb 06                	jmp    1008b9 <console_vprintf+0x33e>
  1008b3:	89 f0                	mov    %esi,%eax
  1008b5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1008b9:	85 f6                	test   %esi,%esi
  1008bb:	7f e5                	jg     1008a2 <console_vprintf+0x327>
  1008bd:	8b 34 24             	mov    (%esp),%esi
  1008c0:	eb 15                	jmp    1008d7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1008c2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1008c6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1008c7:	0f b6 11             	movzbl (%ecx),%edx
  1008ca:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008ce:	e8 2c fc ff ff       	call   1004ff <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1008d3:	ff 44 24 04          	incl   0x4(%esp)
  1008d7:	85 f6                	test   %esi,%esi
  1008d9:	7f e7                	jg     1008c2 <console_vprintf+0x347>
  1008db:	eb 0f                	jmp    1008ec <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1008dd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008e1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1008e6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1008e7:	e8 13 fc ff ff       	call   1004ff <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1008ec:	85 ed                	test   %ebp,%ebp
  1008ee:	7f ed                	jg     1008dd <console_vprintf+0x362>
  1008f0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008f2:	47                   	inc    %edi
  1008f3:	8a 17                	mov    (%edi),%dl
  1008f5:	84 d2                	test   %dl,%dl
  1008f7:	0f 85 96 fc ff ff    	jne    100593 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1008fd:	83 c4 38             	add    $0x38,%esp
  100900:	89 f0                	mov    %esi,%eax
  100902:	5b                   	pop    %ebx
  100903:	5e                   	pop    %esi
  100904:	5f                   	pop    %edi
  100905:	5d                   	pop    %ebp
  100906:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100907:	81 e9 80 09 10 00    	sub    $0x100980,%ecx
  10090d:	b8 01 00 00 00       	mov    $0x1,%eax
  100912:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100914:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100915:	09 44 24 14          	or     %eax,0x14(%esp)
  100919:	e9 aa fc ff ff       	jmp    1005c8 <console_vprintf+0x4d>

0010091e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  10091e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100922:	50                   	push   %eax
  100923:	ff 74 24 10          	pushl  0x10(%esp)
  100927:	ff 74 24 10          	pushl  0x10(%esp)
  10092b:	ff 74 24 10          	pushl  0x10(%esp)
  10092f:	e8 47 fc ff ff       	call   10057b <console_vprintf>
  100934:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100937:	c3                   	ret    
