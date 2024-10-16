.data

	o: .word 111
	p: .word 112
	x: .word 120


.text	
	li t0 0
	li t1 500
	li t4 0xffff0000
	li t5 0xffff0004
	
	boucle:
		lw t2 0(t4)
		beqz t2 rien
		lw t2 0(t5)
		lw t3 p
		beq t2 t3 augmente_t0
		lw t3 o
		beq t2 t3 diminue_t0
		lw t3 x
		beq t2 t3 exit
		
	augmente_t0:
		addi t0 t0 1	
		mv a0 t0
		li a7 1
		ecall
		li t2 0
		mv a0 t1
		li a7 32
		ecall
		j boucle
	diminue_t0:
		addi t0 t0 -1
		li t2 0
	rien:
		mv a0 t0
		li a7 1
		ecall
		mv a0 t1
		li a7 32
		ecall
		j boucle
	
	exit:
		li a7 10
		ecall
		
	
