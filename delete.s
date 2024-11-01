.data
	largeur_pixel:   .word 256
	hauteur_pixel:	 .word 256
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8
	
	RetChar: .ascii "\n"
	
.text

	j main
	
	
	
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
	
	
	I_coordToAdresse:
		#prologue:
		addi sp sp -12
		sw ra 0(sp)
		lw s1 4(sp)
		lw s2 8(sp)
		

		
		#corps:
		li t0 0x10010000
		li t1 32
		mul a1 a1 t1
		add a0 a0 a1
		slli a0 a0 2
		add a0 a0 t0
		
		#épilogue
		lw ra 0(sp)
		lw s1 4(sp)
		lw s2 8(sp)
		addi sp sp 12
		jr ra	
		
			
	I_adresseToCoord:
		#prologue:
		addi sp sp -8
		sw ra 0(sp)
		sw s1 4(sp)
			
		#corps:
		li t0 0x10010000
		li t1 32
		sub t4 a0 t0
		srli t4 t4 2
		
		rem a0 t4 t1
		div a1 t4 t1
		
		## Trouvons l'abs avec cette formule : ( (adresse - adresse_debut) % (4 * I_Largeur ) / 4
		
		## Trouvons l'ordonne avec cette formule : (adresse - adresse_debut) / (4 * I_hauteur)
		
			
		#épilogue:
		lw ra 0(sp)
		addi sp sp 8								
		jr ra

	main:
		###################### Test de la fonction I_coordToAdresse et I_adresseToCoord
		li a0 31
		li a1 1
		jal I_coordToAdresse
		
		jal I_adresseToCoord
		mv a0 a1
		li a7 1
		ecall
		######################
	
	exit:
		li a7 10
		ecall
