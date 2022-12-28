.data
a: .space 36
terminate: .asciiz "rminate the program Please enter -1 for row and -1 for column"
titleRow:      .asciiz "Enter a row number:"
rowEntered:    .asciiz "Rows you entered: "
titleColumn:   .asciiz "Enter a column number:"
columnEntered: .asciiz "Columns you entered: "
newLine1:       .asciiz "\n" 
enterValue: .asciiz "Please enter 0 or 1: "

.text
la $t3, a
addi $t4, $t4, -1
li $t0, 0
addi $t1, $t1, 9
loop1:
bgt $t0, $t1, exit
sw $t4, 0($t3)
addi $t0, $t0, 1
addi $t3, $t3, 4

j loop1

exit:
loop2:
li $t0, 0
li $t3, 0
la $t3, a
addi $t1, $t1, 9
bgt $t0, $t1, exitloop
li $v0, 1
lw $a0, 0($t3)
syscall
addi $t0, $t0, 1
addi $t3, $t3, 4
j loop2
exitloop: