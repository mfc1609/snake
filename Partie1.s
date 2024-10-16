.text

li t0 1
li t1 500
li t2 11

boucle:
	beq t0 t2 exit
	mv a0 t0
	li a7 1
	ecall
	addi t0 t0 1
	mv a0 t1
	li a7 32
	ecall
	j boucle	
exit:
	li a7 10
	ecall
