
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
#define PRIORITYCHECK	2
#endif

void
start(void)
{
  400000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
proc_priority(int priority)
{
	asm volatile("int %0\n"
  400001:	bb 04 00 00 00       	mov    $0x4,%ebx
  400006:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400008:	cd 30                	int    $0x30
  40000a:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  40000c:	ba 01 00 00 00       	mov    $0x1,%edx
  400011:	87 15 04 80 19 00    	xchg   %edx,0x198004
	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
		// get a lock first
		while (atomic_swap(&lock, 1) !=0 ) {
  400017:	85 d2                	test   %edx,%edx
  400019:	75 f1                	jne    40000c <start+0xc>
			continue;
		}
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  40001b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  400021:	66 c7 02 33 09       	movw   $0x933,(%edx)
  400026:	83 c2 02             	add    $0x2,%edx
  400029:	89 15 00 80 19 00    	mov    %edx,0x198000
  40002f:	31 d2                	xor    %edx,%edx
  400031:	87 15 04 80 19 00    	xchg   %edx,0x198004
  400037:	cd 30                	int    $0x30
	int i;

	proc_priority(PRIORITYCHECK);
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  400039:	40                   	inc    %eax
  40003a:	3d 40 01 00 00       	cmp    $0x140,%eax
  40003f:	75 cb                	jne    40000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400041:	66 31 c0             	xor    %ax,%ax
  400044:	cd 31                	int    $0x31
  400046:	eb fe                	jmp    400046 <start+0x46>
