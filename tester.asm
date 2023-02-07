.text
.globl foo


.data
.globl gs
gs: .word 2, -4, 6, -8
.text
.globl main
main:
addi sp, sp, -20
sw ra, 16(sp)
addi a0, sp, 0
la a1, gs
addi a2, zero, 4
jal foo
# ... more code ...
addi a0, zero, 0
lw ra, 16(sp)
addi sp, sp, 20
jr ra


foo: addi sp, sp, -20
sw ra, 16(sp)
sw s3, 12(sp)
sw s2, 8(sp)
sw s1, 4(sp)
sw s0, 0(sp)
addi s0, a0, 0
addi s1, a1, 0
addi s2, a2, 0
addi s3, zero, 0
L1: bge s3, a2, L4
slli t1, s3, 2
add t2, s1, t1
lw t3, (t2)
ble t3, zero, L2
addi a0, t3, 0
jal times10
j L3
L2: addi a0, zero, 0
L3: slli t5, s3, 2
add t6, s0, t5
sw a0, (t6)
addi s3, s3, 1
j L1
L4:
lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw s3, 12(sp)
lw ra, 16(sp)
addi sp, sp, 20
jr ra
.globl times10
times10:
slli t5, a0, 3
# POINT ONE
slli t6, a0, 1
add a0, t5, t6
jr ra