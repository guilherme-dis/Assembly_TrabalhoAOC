.data
	strnl: .asciiz "\n"
	#.align 2#alica os bits de 4 em 4 Bytes
	#n:.word 42 						#int
	#x:.space 4 						#guarda 4 Bytes
	#f:.float 3.1415					#guarda float
	#s:.asciiz "0123456789" 			#guarda string
	#v:.space 40						#vetor
	#v2:.word 0,1,2,3,4,5,6,7,8,9		#vetor já iniciado
	#str1:.asciiz "Digite um int: "
	#str23:.asciiz "\n"

	#add  	rd<=sr+rt
	#addu	rd<=sr+rt(untrapped)N�o trava o processador se dar overflow
	#addi	rd<=sr+rt
	#addiu	rd<=sr+constante
	#i=imediato 
	
	#printf("Digite um int: ");
	#addiu	$v0, $zero, 4  #imprimir string
	
	
	#la $t0,n		pega o endere�o de n e coloca em t0
	#lw $s0,0($t0)	pega o endere�o no t0, na posi��o 0, pega o valor e coloca em $s0
	#syscall
	
	#scanf("%d", &y);
	#addiu	$v0, $zero, 5   #le inteiro
	#syscall
	#sw		$v0, 0($at)     # MEM[at] <- v0 
	#addu	$s0, $zero, $v0 #salva o inteiro lido em s0
	
	#beq = compara se $rs,$rt são iguais == $rs,$rt,label
	#bne = $rs,$rt,label, se rs!=rt pula para o label
	#slt = $rd,$rs,$rt se rs<rt rd=1 senhão rd=0
	
	#return 0;
	#addiu	$v0, $zero, 10
	#syscall
	
	

	
	#lo tem o resultado
	#hi tem o resto
	
	#mulu $t0,$a0,$a1 A multiplica��o cai direto em t0
	#li $s0,42, (pseudo instru��o) #addiu $s0,$zero,42
	
.macro return0
	addiu	$v0, $zero, 10
	syscall
.end_macro

.macro printInt(%intV)
	addiu	$v0, $zero, 1
	addu	$a0, $zero, %intV
	syscall
.end_macro


#printf com uma string que eu queria
.macro printStr(%strn)
	addiu	$v0, $zero, 4
	la	$a0, %strn
	syscall
.end_macro

.macro atoi(%strn)
	la $t0,%strn		
	lw $s1,0($t0)
	addiu $s1,$s1,-48
.end_macro

.macro printNL
	addiu	$v0, $zero, 4
	la	$a0, strnl
	syscall	
.end_macro

.macro	readInt(%reg)
	addiu	$v0, $zero, 5
	syscall
	addu	%reg, $zero, $v0
.end_macro
.macro PUSH
	addi 	$sp,$sp,-60
	sw 		$ra,4($sp)
	sw 		$a0,8($sp)
	sw 		$a1,12($sp)
	sw 		$a2,16($sp)
	sw 		$a3,20($sp)
	sw 		$v0,24($sp)
	sw 		$v1,28($sp)
	sw 		$s0,32($sp)
	sw 		$s1,36($sp)
	sw 		$s2,40($sp)
	sw 		$s3,44($sp)
	sw 		$s4,48($sp)
	sw 		$s5,52($sp)
	sw 		$s6,56($sp)
	sw 		$s7,60($sp)
.end_macro
.macro POP
	lw 		$ra,4($sp)
	lw 		$a0,8($sp)
	lw 		$a1,12($sp)
	lw 		$a2,16($sp)
	lw 		$a3,20($sp)
	lw 		$v0,24($sp)
	lw 		$v1,28($sp)
	lw 		$s0,32($sp)
	lw 		$s1,36($sp)
	lw 		$s2,40($sp)
	lw 		$s3,44($sp)
	lw 		$s4,48($sp)
	lw 		$s5,52($sp)
	lw 		$s6,56($sp)
	lw 		$s7,60($sp)
	addi 	$sp,$sp,60
.end_macro
.macro openFile(%strn)
	li $v0,13       # system call for open file
  	la   $a0, %strn     # output file name
  	li   $a1, 0        # Open for writing (flags are 0: read, 1: write)	#1 pq quero ler
  	li   $a2, 0        # mode is ignored 							#n�o sei o que significa isso
  	syscall            # open a file (file descriptor returned in $v0)
  	addu $s0,$zero, $v0 #estou salvando o descritor do arquivo
.end_macro
.macro EndFile
	li   $v0, 16       # system call for close file
  	move $a0, $s0      # file descriptor to close
  	syscall            # close file
.end_macro 


#scanf e salvando em uma variavel na mem�ria
#tentar fazer isso em macro
	#addiu $v0,$zero,5
	#syscall
	#la $at,y
	#sw $v0,0($at)
	#addu	$s0, $zero, $v0#deixando salvo no s0 tmb





#FUNÇÕES

	#addiu $a0,$zero,42	#COLOCANDO 42 NO A0
	#addiu $a1,$zero,10	#colocando 10

	#jal FUNC1 #coloca no ra o endere�o da pr�xima instru��o, ou seja, o  addiu $a0,$zero,$v0

	#addu $a0,$zero,$v0
	#addiu $v0,$zero,1
	#syscall

#return 0
	#addiu $v0,$zero,10
	#syscall
#FUNC1:
	#addu $t0,$a0,$a1
	#addu $v0,$zero,$t0
	#jr $ra	#pula para o endere�o nesse registrador ra



	
