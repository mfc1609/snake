.data
	largeur_pixel:   .word 240
	hauteur_pixel:	 .word 240
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8
	
	tete: 		.word 0
	ind_tete: 	.word 0
	queue: 		.word 0
	ind_queue: 	.word 0
	max: 		.word 900
		
.text

main:
	jal F_creer
	
	la t0, tete        
    	sw a0, 0(t0)       
    
  	la t1, queue        
    	sw a0, 0(t1)
    	
	li a1 10
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	jal F_defiler
	
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

F_creer:
	addi sp sp -4
	sw ra (sp)
	
	jal I_largeur
	mv t1 a0
	jal I_hauteur
	mv t2 a0
	mul a0 t1 t2
	slli a0 a0 2
	li a7 9
	ecall
	
	lw ra (sp)
	addi sp sp 4
	jr ra
	
F_enfiler:
	
	la t0 tete
	lw t1 0(t0)
	
	la t2 ind_tete
	lw t3 0(t2)
	
	lw t4 max
	
	# Ajoute le pixel 
	sw a1 0(a0)
	addi a0 a0 4
	
	#incr l'adresse
	addi t1 t1 4
	sw t1 (t0)
	
	#incr l'indice et attention a pas dépasser tab donc rem
	addi t3 t3 1
	rem t3 t3 t4
	sw t3 (t2)
	
	
	
	jr ra
	
F_defiler:

	la t0 queue
	lw t1 0(t0)
	
	la t2 ind_queue
	lw t3 0(t2)
	
	lw t4 max
	
	addi t1 t1 4
	sw t1 (t0)
	
	addi t3 t3 1
	rem t3 t3 t4
	sw t3 (t2)
	
	jr ra
	
	
	
	
	
	
	
	
