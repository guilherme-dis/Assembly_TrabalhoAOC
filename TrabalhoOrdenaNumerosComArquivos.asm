.include "bibliUtil.asm"
.data
	.align 2
	buff:.space 4
	strFilename:.asciiz "numeros.txt"			#Nome do arquivo
	vetor:.space 4000						#vetorPrincipal
	vetoraux:.space 16						#vetor auxiliar de 4 posições
.text
  	jal openfile	#função que le o arquivo, e joga os dados para o vetor principal.
  	la $a0,vetor	#argumento 1 da função sort------Primeira posição do vetor
  	li $a1,1000	#argumento 2 da função sort------Qtd de elementos
	jal bsort		#função bubble sort
	jal MOSTRA	#função que mostra dos dados na tela
  	EndFile		#fechar o arquivo
	return0		#return 0
bsort:
	PUSH
	move $s2, $a0 		#salvando os argumentos
	move $s3, $a1 		#salvando os argumentos
	move $s0, $zero 	
	for1tst: slt $t0, $s0, $s3 
	beq $t0, $zero, exit1 
	addi $s1, $s0, -1 
	for2tst: slti $t0, $s1,0 
	bne $t0, $zero, exit2 
	sll $t1, $s1,2
	add $t2, $s2, $t1 
	lw $t3,0($t2)
	lw $t4,4($t2)
	slt $t0, $t4, $t3
	beq $t0, $zero, exit2
	move $a0, $s2
	move $a1, $s1 
	jal swap		#função que troca os dados
	addi $s1, $s1, -1
	j for2tst 
	exit2: addi $s0, $s0,1
	j for1tst 
	exit1:
	POP
	jr $ra
swap: sll $t1, $a1, 2 		# $t1 = k * 4
 add $t1, $a0, $t1 			# $t1 = v+(k*4)
 						# (endereço de v[k])
 lw $t0, 0($t1) 			# $t0 (temp) = v[k]
 lw $t2, 4($t1) 			# $t2 = v[k+1]
 sw $t2, 0($t1) 			# v[k] = $t2 (v[k+1])
 sw $t0, 4($t1) 			# v[k+1] = $t0 (temp)
 jr $ra 					# retorna

MOSTRA:
	PUSH
	la $s4,vetor			#ponteiro para o vetorPrincipal
	li $t2,0
	li $t3,1000  			#linha que determina o tamanho do vetor
	for:
	addiu $t2,$t2,1
	
	lw $t1,0($s4)
	addiu $s4,$s4,4
	printInt($t1)
	printNL
	bne $t2,$t3,for
	fim:
	POP
  	jr $ra
  	
  	
  	
openfile:
	PUSH
	openFile(strFilename)#Abre o arquivo e faz o descritor ficar no s0 s0=descritor do arquivo
  	la $s6,vetoraux		#ponteiro para o vetoraux
  	la $s4,vetor			#ponteiro para o vetorPrincipal
  	
  	
  	
  	addiu $t7,$zero,13 #\n em ascii
  	addiu $t6,$zero,44 #,  em ascii
  	addiu $t5,$zero,13
	WHILE1:
	beq $s7,$t7,SAI1			#se o número lido é o \n, ou seja, 13 da tabela
	addiu $v0,$zero,14			#Coloca no v0 o comando 14 para le do arquivo
	addu $a0,$s0,$zero			#coloca o descritor no a0
	la $a1,buff				#pega o endereço do buff, e coloca em a1
	addiu $a2,$zero,1
	syscall
	lb $s7,0($a1)
	beq $s7,$t6,BUFFBUILDER		#se achar uma virgula SIGNIFICA QUE JÁ ACHOU UM NÚMERO COMPLETO E JÁ PODE FAZER A OPERAÇAO DE BUFFBUILDER
	beq $s7,$t5,SAI1
	atoi(buff)				#pega a string e converte para int e coloca em $s1	
		
	sw $s1,0($s6)				#coloca o valor que eu achei e converti na posição do vetoraux
	
	addiu $s6,$s6,4			#para o vetor aux apontar para a próximo espaço dele
  	j WHILE1
	BUFFBUILDER:
	la $s6,vetoraux
	lw $t4,0($s6)
	
	mulu $t4,$t4,1000
	addu $t3,$zero,$t4
	
	
	lw $t4,4($s6)
	mulu $t4,$t4,100
	addu $t3,$t3,$t4
	
	
	lw $t4,8($s6)
	mulu $t4,$t4,10
	addu $t3,$t3,$t4
	
	
	lw $t4,12($s6)
	addu $t3,$t3,$t4
	
	sw $t3,0($s4)		#pego o valor que achei, e jogo no vetor principal
	addiu $s4,$s4,4	#faço o ponteiro principal rodar
	#printInt($t3)
	#printNL
	j WHILE1

	SAI1:
	POP
jr $ra
