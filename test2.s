.data
	debut: .word 0x10010000
	fin:   .word 0x10050000
	rouge: .word 0x00ff0000
	
.text
		li t0 0x10010000
		li t1 0x10050000
		li t2 0x00ff0000
		mv t3, t0
		li t4 0             	#ligne
		li t5 0	    		#colonne
		li a1 16		#ligne_max
		li a2 32		#colonne_max
		boucle:
			beq t5 a2 incre_ligne
			sw t2 (t3)
			addi t3 t3 4
			addi t5 t5 1
			j boucle
			
			
		incre_ligne:
			beq t4 a1 exit
			addi t4 t4 1
			addi t5 t5 -32
			j boucle	
		exit:
			li a7 10
			ecall
