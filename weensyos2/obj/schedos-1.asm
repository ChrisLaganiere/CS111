
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
#define PRIORITYCHECK	2
#endif

void
start(void)
{
  200000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
proc_priority(int priority)
{
	asm volatile("int %0\n"
  200001:	bb 02 00 00 00       	mov    $0x2,%ebx
  200006:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200008:	cd 30                	int    $0x30
  20000a:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  20000c:	ba 01 00 00 00       	mov    $0x1,%edx
  200011:	87 15 04 80 19 00    	xchg   %edx,0x198004
	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
		// get a lock first
		while (atomic_swap(&lock, 1) !=0 ) {
  200017:	85 d2                	test   %edx,%edx
  200019:	75 f1                	jne    20000c <start+0xc>
			continue;
		}
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  20001b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200021:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200026:	83 c2 02             	add    $0x2,%edx
  200029:	89 15 00 80 19 00    	mov    %edx,0x198000
  20002f:	31 d2                	xor    %edx,%edx
  200031:	87 15 04 80 19 00    	xchg   %edx,0x198004
  200037:	cd 30                	int    $0x30
	int i;

	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  200039:	40                   	inc    %eax
  20003a:	3d 40 01 00 00       	cmp    $0x140,%eax
  20003f:	75 cb                	jne    20000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200041:	66 31 c0             	xor    %ax,%ax
  200044:	cd 31                	int    $0x31
  200046:	eb fe                	jmp    200046 <start+0x46>
