.data
	largeur_pixel:   .word 256
	hauteur_pixel:	 .word 256
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8

	
		
			
	
.text




	main:
		#jal I_creer
		#li a0 2
		#li a1 2
		#li a2 0x0000ff00
		call O_creer
		
		
	exit:
		li a7 10
		ecall
	I_largeur:
		la t0 largeur_pixel
		lw t1, 0(t0)
		la t2 largeur_unit
		lw t3, 0(t2)
		div a0 t1 t3
		jr ra
		
		
	I_hauteur:
		la a1 hauteur_pixel
		lw a2, 0(a1)
		la a3 hauteur_unit
		lw a4, 0(a3)
		div a0 a2 a4
		jr ra
	
		
	I_creer:
		#prologue:
		addi sp sp -4
		sw ra (sp)
		#corps:
		jal I_largeur
		mv t1 a0
		jal I_hauteur
		mv t2 a0
		mul a0 t1 t2
		slli a0 a0 2
		li a7 9
		ecall
		#épilogue:
		lw ra (sp)
		addi sp sp 4
		jr ra
		
		
		

	I_coordToAdresse:
		#prologue:
		addi sp sp -4
		sw ra 0(sp)
		
		#corps:
		li t0 0x10010000
		li t1 32
		mul a1 a1 t1
		add a0 a0 a1
		slli a0 a0 2
		add a0 a0 t0
		
		#épilogue
		lw ra 0(sp)
		addi sp sp 4
		jr ra	
		
			
	I_adresseToCoord:
		#prologue:
		addi sp sp -8
		sw ra 0(sp)
		sw s1 4(sp)
			
		#corps:
		li t0 0x10010000
		li t1 32
		sub a0 a0 t0
		srli a0 a0 2
		rem a1 a0 t1
		sub a2 a0 a1
		div a0 a2 t1
		
			
		#épilogue:
		lw ra 0(sp)
		lw s1 4(sp)
		addi sp sp 8								
		jr ra
		
		
	I_plot:
		#prologue:
		addi sp sp -4
		sw ra 0(sp)
		
		#corps:
		jal I_coordToAdresse
		li t0 0
		li t1 1
		mv t2 a0
		sw a2 (t2)		
		#épilogue:
		lw ra 0(sp)
		addi sp sp 4
		jr ra
		
		
	O_creer:
		#prologue:
		
		
		#corps:
		li a7 63
		ecall
		mv a0 t1
		li a7 1
		ecall
		li a7 63
		ecall
		li a7 1
		ecall
		mv a0 a1
		
		
		
		
		#épilogue:
	
			
		
