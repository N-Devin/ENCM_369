# stub1.asm
# ENCM 369 Winter 2023 Lab 2
# This program has complete start-up and clean-up code, and a "stub"
# main function.

# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciz	"***About to exit. main returned "
exit_msg_2:
	.asciz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust sp, then call main
	andi	sp, sp, -32		# round sp down to multiple of 32
	jal	main
	
	# when main is done, print its return value, then halt the program
	sw	a0, main_rv, t0	
	la	a0, exit_msg_1
	li      a7, 4
	ecall
	lw	a0, main_rv
	li	a7, 1
	ecall
	la	a0, exit_msg_2
	li	a7, 4
	ecall
        lw      a0, main_rv
	addi	a7, zero, 93	# call for program exit with exit status that is in a0
	ecall
# END of start-up & clean-up code.
#
# Local Variable	Register
# int *p		s1
# int *guard		s2
# int min 		s3
# int j			s4
# int k			s5
# int *alpha		s6
# int *beta		s7
# int compare		t1
# Below is the stub for main. Edit it to give main the desired behaviour.	
	.data
        .globl  alpha
alpha:  .word 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1
        .globl  beta
beta:   .word 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70

	.text
	.globl	main
	
main:
	la s7,alpha		#p1=alpha
	la s8,beta		#p2=beta
	addi s3,s7,32		#guard = p+8
	lw s4,(s7)		#min = *p
L0:
	addi s7,s7,4		#p++
	beq s7,s3,L1		#if (p==guard)goto l1
	lw t0,(s7)		#t0 = *p
	bge t0,s4,L3		#if (*p>=min) goto L3
	lw s4,(s7)		#min = *p
	addi s7,s7,4		#p++
L3:
	j L0 			#jump to L0 	
	
L1:
				
	li   s5, 0  		# j = 0
	li   s6, 7  		# k = 7
	la s7,alpha
	la s8,beta
	addi s9,s9,8
	
L5:
	bge s5,s9,L4 		#if (j>=8) goto L4
	slli t1,s6,2		#shift right by 2
	add t2,s8,t1
	lw t3,(t2)
	slli t4,s5,2
	add t5,s7,t4
	sw t3,(t5)	
	addi s5,s5,1
	addi s6,s6,-1
	j    L5        		# goto loop
	
L4:
	add	a0, zero, zero	# return value from main = 0
	jr	ra
