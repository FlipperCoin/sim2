# Operands to multiply
.data
a: .word 0xBAD
b: .word 0xFEED

.text
main:   # Load data from memory
		la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)
        
        # t6 will contain the result
        add		t6, x0, x0

        # Mask for 16x8=24 multiply
        ori		t0, x0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        
####################
# Start of your code

slli t3, t3, 16
srli t3, t3, 16
slli t4, t4, 16
srli t4, t4, 16

srli t1, t3, 8
beq t1, x0, half_mul

srli t1, t4, 8
beq t1, x0, half_mul

full_mul:
        andi t1, t3, 0xFF
        mul t5, t4, t1 
        and t5, t5, t0

        srli t1, t3, 8
        mul t6, t4, t1 
        and t6, t6, t0
        slli t6, t6, 8

        add t6, t6, t5
        jal x0, finish

half_mul:
        mul t6, t4, t3 
        and t6, t6, t0

# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0

# End of your code
####################
		
finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall


