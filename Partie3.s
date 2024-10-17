.data
	largeur_pixel:   .word 256
	hauteur_pixel:	 .word 256
	largeur_unit:    .word 8
	hauteur_unit:	 .word 8
	random_int:  .space 4

	
		
			
	
.text




	main:
		#jal I_creer
		li a0 6
		#li a1 2
		#li a2 0x0000ff00
		#li a0 31
		#li a1 31
		#jal I_coordToAdresse
		jal O_creer
		
		
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
		addi sp sp -8
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
		lw s1 4(sp)
		addi sp sp 8
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
		#Prologue
		sw ra 0(sp)
		sw s1 4(sp) 
		sw s2 8(sp) 
		sw s3 12(sp)  
		sw s4 16(sp)   
		sw s5 20(sp)  
		sw s6 24(sp)              
		
		#Corps
		
		mv s6 a0                  
		
		# Création du tableau
		
		li a1 136 
		add a0 a0 a1 
		slli a0 a0 2 
		li a7 9  
		ecall   
		mv s7 a0                  
		
		
		
		# Remplir le tableau avec les bords de l'image
		
		li a6 0  
		li t2 32  
		li a0 0 
		li a1 0               
		
		
		
		boucle1:
		beq a6 t2 fin_boucle1
		jal I_coordToAdresse 
		sw a0 0(s7) 
		addi s7 s7 4  
		addi a6 a6 1  
		mv a0 a6       
		j boucle1     
		    
		fin_boucle1:
		li a6 1
		addi a1 a1 1
		
		boucle2:
		li a0 0 
		beq a6 t2 fin_boucle2
		jal I_coordToAdresse 
		sw a0 0(s7)    
		addi s7 s7 4
		addi a6 a6 1   
		mv a1 a6   
		j boucle2                  
		
		fin_boucle2:
		li a0 1
		li a6 1
		
		boucle3:
		
		li a1 31                   
		beq a6 t2 fin_boucle3   
		jal I_coordToAdresse 
		sw a0 0(s7)       
		addi s7 s7 4  
		addi a6 a6 1  
		mv a0 a6     
		j boucle3                   
		
		fin_boucle3:
		li a6 1
		li a1 1
		
		boucle4:
		li a0 31                     
		li t2 31        
		beq a6 t2, random 
		jal I_coordToAdresse  
		sw a0 0(s7)       
		addi s7 s7 4    
		addi a6 a6 1
		mv a1 a6   
		j boucle4                   
		
		random:
		li t0 28 
		li t1 0   
		li a5 0               
		
		boucle5:
		beq a5 s6 epilogue 
		li a7 41    
		ecall
		rem a0 a0 t0             
		bge a0 t0 boucle5
		blt a0 t1 boucle5
		addi a0 a0 2             
		sw a0 0(s7)          
		addi s7 s7 4       
		addi a5 a5 1       
		j boucle5                  
		
		epilogue:
		lw ra 0(sp) 
		lw s1 4(sp)
		lw s2 8(sp)
		lw s3 12(sp)  
		lw s4 16(sp)  
		lw s5 20(sp)
		lw s6 24(sp)  
		addi sp sp 32   
		jr ra                   
		
				
		
			
		
