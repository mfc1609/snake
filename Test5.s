continue3:
		beq s5 s3 nourriture2
		j avance2
		
		nourriture2:
		mv a0 s4
		mv a1 s3
		li a2 0x00000000
		jal I_plot
		mv s3 s5
		mv s4 s6
		jal nourriture
		j premiere
		
		
		
		
		beq s4 s6 continue3