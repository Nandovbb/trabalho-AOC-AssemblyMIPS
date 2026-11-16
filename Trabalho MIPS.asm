.data
    msg1:     .asciiz "Digite um numero maximo (1 < numero < 10000): "
    msg2:    .asciiz "Numeros nao primos de 1 ate o valor digitado:\n"
    erro_msg:   .asciiz "Valor invalido! Tente novamente.\n"
    nada:     .asciiz " "

.text

main:
ler:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    li $t0, 1
    ble $s0, $t0, erro

    li $t0, 10000
    bge $s0, $t0, erro

    j inicio

erro:
    li $v0, 4
    la $a0, erro_msg
    syscall
    j ler

inicio:
    li $v0, 4
    la $a0, msg2
    syscall

    li $s1, 1

numeros:
    bgt $s1, $s0, fim

    li $t0, 1
    beq $s1, $t0, nao_primo

    li $s2, 2

divisores:
    mul $t1, $s2, $s2
    bgt $t1, $s1, proximo_numero

    div $s1, $s2
    mfhi $t2
    beqz $t2, nao_primo

    addi $s2, $s2, 1
    j divisores

nao_primo:
    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, nada
    syscall

proximo_numero:
    addi $s1, $s1, 1
    j numeros

fim:
    li $v0, 10
    syscall