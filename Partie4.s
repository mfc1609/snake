.data

.text


	main:
		jal F_creer
		li a1 0x10010000
		jal F_enfiler
	exit:
		li a7 10
		ecall
	
	F_creer:
		#prologue:
		addi sp sp -4
		sw ra 0(sp)
		
		#corps:
		li a0 1024
		slli a0 a0 2
		li a7 9
		ecall 
		
		#épilogue:
		lw ra 0(sp)
		addi sp sp 4
		jr ra
		
	F_enfiler:
		#prologue:
		addi sp sp -4
		sw ra 0(sp)
		
		#corps:
		lw t0 0(a0)
		mv t0 a1
		sw t0 0(a0)
		
		#épilogue:
		lw ra 0(sp)
		addi sp sp 4
		
		
		