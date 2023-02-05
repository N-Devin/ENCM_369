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
	li	s0,0xa000	# boat = 0xa000
	li	s1,0x3000	# plane = 0x3000
	la	s2,train	# s2 = train
	lw	s3,(s2)		# train = 0x20000
	addi	sp,sp,-8
    	sw      ra,0(sp)	# save return value
    	sw	s3,4(sp)
	addi	a1,a1,6		# first
	addi	a2,a2,4		# second
	addi	a3,a3,3		# third
	addi	a4,a4,2		# fourth
	jal	proc_A		# call proc A
	add	s0,s0,a0	# boat + procA return
	sub	t1,s0,s1	# temp = boat - plane
    	lw	s3,4(sp)
	add	s3,s3,t1	# train = train + temp
    	lw      ra,0(sp)	# return value
	addi	sp,sp,8
	li      a0, 0   	# return value from main = 0
	jr	ra
	
proc_A:  
    	addi    sp, sp, -28	# extend stack pointer
    	sw      ra, 0(sp)	# save return value
    	sw      a1, 4(sp)	# save first
    	sw	a2, 8(sp)	# save second
    	sw	a3, 12(sp)	# save third
    	sw	a4, 16(sp)	# save fourth
    	sw      s0, 20(sp)	# save boat
    	sw      s1, 24(sp)	# save plane
    	
	lw	s0, 4(sp)	# s0 = first
	lw	s1, 8(sp)	# s1 = second
	lw	s2, 12(sp)  	# s2 = third
	lw	s3, 16(sp)   	# s3 = fourth 
	add	s4,zero,zero	# s4 = alpha
	add	s5,zero,zero	# s5 = beta
	add	s6,zero,zero	# s6 = gamma
	
	mv 	a1,s3		# a1 = fourth
	mv	a2,s2		# a2 = third	
	
	jal	procB		# call procB
	mv	s5,a0		# beta = return from procB
	
	mv	a1,s1		# a1 = second
	mv	a2,s0		# a2 = first
	
	jal	procB		# call procB
	mv	s4,a0		# gamma = return value
	
	mv	a1,s2		# a1 = third
	mv	a2,s3		# a2 = fourth
	
	jal	procB		# call procB
	mv	s6,a0		# alpha = return value
	
	add	t1,s4,s5	# add temp = alpha + beta
	add	a0,t1,s6	# add return value a0 = temp + gamma
    
    	lw      ra, 0(sp)	# reset return value
    	lw      a1, 4(sp)	# reset first
    	lw	a2, 8(sp)	# reset second
    	lw	a3, 12(sp)	# reset	third
    	lw	a4, 16(sp)	# reset fourth
    	lw      s0, 20(sp)	# reset boat
    	lw      s1, 24(sp)	# reset plane
    	addi    sp, sp, 28	# reset stack pointer
    	jr	ra		#
    	
procB:	
	slli	t1,a1,8 	# first arg * 256
	add	a0,t1,a2	# value of previous + second arg
	jr	ra
	
	
