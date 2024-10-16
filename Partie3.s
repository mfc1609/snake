.data
	largeur_pixel:   .word 256
	hauteur_pixel:	 .word 256
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8
	
.text
	I_largeur:
		la t0 largeur_pixel
		lw t1, 0(t0)
		la t2 largeur_unit
		lw t3, 0(t2)
		div a0 t1 t3
		mv a0 t3
		jr ra
		
		
	I_hauteur:
		la a1 hauteur_pixel
		lw a2, 0(a1)
		la a3 hauteur_unit
		lw a4, 0(a3)
		div a0 a2 a4
		mv a0 a4
		jr ra
	
		
	I_creer:
		mul a5 t3 a4
		slli a5 a5 2
		mv a0 a5
		li a7 9
		ecall
		jr ra
	
		

			
		
	
			
		