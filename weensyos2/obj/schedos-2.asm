
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
#define PRIORITYCHECK	2
#endif

void
start(void)
{
  300000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
proc_priority(int priority)
{
	asm volatile("int %0\n"
  300001:	bb 02 00 00 00       	mov    $0x2,%ebx
  300006:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300008:	cd 30                	int    $0x30
  30000a:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  30000c:	ba 01 00 00 00       	mov    $0x1,%edx
  300011:	87 15 04 80 19 00    	xchg   %edx,0x198004
	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
		// get a lock first
		while (atomic_swap(&lock, 1) !=0 ) {
  300017:	85 d2                	test   %edx,%edx
  300019:	75 f1                	jne    30000c <start+0xc>
			continue;
		}
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  30001b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  300021:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  300026:	83 c2 02             	add    $0x2,%edx
  300029:	89 15 00 80 19 00    	mov    %edx,0x198000
  30002f:	31 d2                	xor    %edx,%edx
  300031:	87 15 04 80 19 00    	xchg   %edx,0x198004
  300037:	cd 30                	int    $0x30
	int i;

	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  300039:	40                   	inc    %eax
  30003a:	3d 40 01 00 00       	cmp    $0x140,%eax
  30003f:	75 cb                	jne    30000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300041:	66 31 c0             	xor    %ax,%ax
  300044:	cd 31                	int    $0x31
  300046:	eb fe                	jmp    300046 <start+0x46>
