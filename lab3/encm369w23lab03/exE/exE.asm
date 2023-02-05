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
# Global variables
	.data
	
	.globl	aaa	
aaa:	.word	11, 11, 3, -11			# int aaa[ ] = { 11, 11, 3, -11}
	.globl	bbb	
bbb:	.word	200, -300, 400, 500		# int bbb[ ] = { 200, -300, 400, 500 }
	.globl	ccc	
ccc:	.word	-2, -3, 2, 1, 2, 3		# int ccc[ ] = { -2, -3, 2, 1, 2, 3 }

# Below is the stub for main. Edit it to give main the desired behaviour.
	.text
	.globl	main
main:
	addi 	sp,sp,-16 #allocate 5 words
	sw 	ra,12(sp) 
	sw	 s2, 8(sp)
	sw	 s1, 4(sp)
	sw 	s0,0(sp)
	li 	s2,1000 # blue = 1000
	li 	a0,10 #first argument = 10
	la	 a1,aaa #second argument holds the address of aaa[0]
	li 	a2,4 # third argument = 4
	jal	 special_sum #jump to special_sum label
	add 	s0,zero,a0 # red = returm from labek special_sum
	li 	a0,200	# first argument = 200
	la	 a1,bbb	#second argument hold address bbb
	li 	a2,4		#third argument = 4
	jal	 special_sum	#jump to special_sum
	add	 s1,zero,a0 
	li 	a0,500
	la 	t0,ccc
	add 	a1,t0,zero
	li 	a2,6
	jal 	special_sum
	add 	s2,s2,a0
	add	 s2,s2,s1
	add	 a0,s2,s0
	lw 	s0,0(sp)
	lw 	s1,4(sp)
	lw 	s2,8(sp)
	lw 	ra,12(sp)
	addi	 sp,sp,16
	jr	ra
	
	
special_sum:
# s0 = bound
# s1 = x
# s2 = n
# s3 = result
# s4 = i
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s4,16(sp)# i
	sw s3,12(sp)# result
	sw s2, 8(sp)# n
	sw s1, 4(sp)# x
	sw s0,0(sp) #bound
	mv s0,a0
	mv s1,a1	
	mv s2,a2
	li s3,0
	li s4,0 # i = 0
	j loop	
loop:
	
	slli t0,s4,2
	add t1,s1,t0 #&x[i]
	lw a1,(t1) # x[i]
	mv a0,s0 # a0 = bound
	jal clamp #jump to clamp
	add s3,s3,a0 #store argument 0 to result
	addi s4,s4,1	#i += 1
	blt s4,s2,loop	#if i is bigger than n go to loop label
	mv a0,s3	# move 
	lw s0,0(sp)
	lw s1,4(sp)
	lw s2,8(sp)
	lw s3,12(sp)
	lw s4,16(sp)
	lw ra,20(sp)
	addi sp,sp,24
	jr ra		

clamp:
	sub t0,zero,a0
	blt a1,t0,returnsub
	bgt a1,a0,returnpos
	mv a0,a1
	jr ra
returnsub:
	mv a0,t0
	jr ra
	
returnpos:
	jr ra 
