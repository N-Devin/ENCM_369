# stub1.asm
# ENCM 369 Winter 2023
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

# Below is the stub for main. Edit it to give main the desired behaviour.

	.data
	.globl train
train: 	.word  0x20000	

	.text
	.globl	main
main:
	lui	t0,0x0b670	
	li	t5,0x6a009005
	li	t6,0x0fffa000
	
	srli    t1, t0, 5
        slli    t2, t0, 3
        or	t3, t5, t6
        andi    t4, t5, 0x3ff
        xor     s0, t5, t6
        xori    s1, t5, -16
	
	jr	ra
	

	
	
