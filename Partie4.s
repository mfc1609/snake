.data
	largeur_pixel:   .word 240
	hauteur_pixel:	 .word 240
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8
	
	tete: 		.word 0
	ind_tete: 	.word 0
	queue: 		.word 0
	ind_queue: 	.word 0
	nb_elems:	.word 0
	max: 		.word 900
		
.text

main:
	jal F_creer
	
	la t0, tete        
    	sw a0, 0(t0)       
    
  	la t1, queue        
    	sw a0, 0(t1)
    	
	li a1 2
	jal F_enfiler
	li a1 4
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	li a1 6
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	li a1 8
	jal F_enfiler
	jal F_defiler
	jal F_defiler
	jal F_defiler
	
	li a1 0
	jal F_valeurIndice
	li a1 9
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	jal F_enfiler
	
	li a1 12
	jal F_valeurIndice
	
	li a1 13
	jal F_valeurIndice
	
	
	#test
	addi a0 a0 400
	jal F_contient
	
	jal F_lister
	
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
	
	lw t6 max
	 
	sw a1 0(t1)
	
	addi t1 t1 4
	sw t1 (t0)
	
	addi t3 t3 1
	bge t3 t6 reset_tete
	
	la t4 nb_elems
	lw t5 0(t4)
	addi t5 t5 1
	sw t5 (t4)
	
	jr ra
	
	reset_tete:
	
		rem t3 t3 t6
		sw t3 (t2)
		sw a0 (t0)
		la t4 nb_elems
		lw t5 0(t4)
		addi t5 t5 1
		sw t5 (t4)
		
		jr ra
	
F_defiler:

	la t0 queue
	lw t1 0(t0)
	
	la t2 ind_queue
	lw t3 0(t2)
	
	lw t6 max
	
	addi t1 t1 4
	sw t1 (t0)
	
	addi t3 t3 1
	bge t3 t6 reset_queue

	la t4 nb_elems
	lw t5 0(t4)
	addi t5 t5 -1
	sw t5 (t4)
	
	jr ra
	
	reset_queue:
	
		rem t3 t3 t6
		sw t3 (t2)
		sw a0 (t0)
		la t4 nb_elems
		lw t5 0(t4)
		addi t5 t5 -1
		sw t5 (t4)
		
		jr ra

F_valeurIndice:
	
	addi sp sp -4
	sw a0 (sp)
	
	la t1 nb_elems
	lw t2 0(t1)
	addi t3 t2 -1
	
	beqz a1 q
	beq a1 t3 t
	
	la t4 queue
	lw t5 (t4)
	
	la t6 ind_queue
	lw t0 (t6)
	
	add t0 t0 a1
	rem t0 t0 t2
	
	slli t0 t0 2
	add t5 t5 t0
	lw a0 (t5)
	li a7 1
	ecall
	j exit_v
	
	
	t:
		
		la t4 tete
		lw t5 (t4)
		addi t5 t5 -4
		lw a0 (t5)
		li a7 1
		ecall
		j exit_v
	
	q:
	
		la t4 queue
		lw t5 (t4)
		lw a0 (t5)
		li a7 1
		ecall

	exit_v:
		lw a0 (sp)
		addi sp sp 4
		jr ra

F_contient:

	lw t0 (a0)
	
	addi sp sp -4
	sw a0 (sp)
	
	bgtz t0 app_s
	
	li a0 0
	li a7 1
	ecall
	j exit_contient 
	
	app_s:
		
		li a0 1
		li a7 1
		ecall
	
	exit_contient:
		
		addi sp sp 4
		lw a0 (sp)
		jr ra

F_lister:

	addi sp sp -4
	sw a0 (sp)

	la t0 queue
	lw t1 (t0)
	
	la t2 tete
	lw t3 (t2)
	
	boucle_liste:
	
		bgt t1 t3 exit_lister
		lw t4 (t1)
		mv a0 t4
		addi t1 t1 4
		li a7 1
		ecall
		j boucle_liste
	
	exit_lister:
		
		lw a0 (sp)
		addi sp sp 4
		jr ra
	
