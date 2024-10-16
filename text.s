.data
	debut: .word 0x10010000
	fin:   .word 0x10050000
	rouge: .word 0x00ff0000
	
.text
		li t0 0x10010000
		li t1 0x10050000
		li t2 0x00ff0000
		mv t3, t0
		
		boucle:
			beq t3 t1 exit
			sw t2 (t3)
			addi t3 t3 4
			j boucle
			
		exit:
			li a7 10
			ecall