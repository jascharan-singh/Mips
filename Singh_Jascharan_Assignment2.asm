##############################################################################
# Subroutine Name: newLine, make, bottomLine, Slash, SlashCode, terminateEcode, nullReg
##############################################################################
# Functional Description:
#newLine: Create a new line
#make: There are five registers which this function make it zero $t0 t0 $t4
#bottomLine:  This function create a line right below the game row
#Slash: This function create a divider in every row of the game
#SlashCode: This function has code to create divider in the game
#terminateEcode: This function has code to print the final output
#nullReg: The funtion has every register to make them null 
##############################################################################
# Explain the parameters passed to the subroutine
#terminateEcode: This function has multiple parimeter which help program to print the final output.
#nullReg: I set the parameter for this to give me t's register and s's registers into null value
# Explain the values returned by the subroutine
#terminateEcode: This function gave me the final output
#nullReg: This function return me the all t's and s's register in null value
##############################################################################
# Register Usage in subroutine:
#$t0 T0 $t7
#$s0 To $s7
#$v0 and $a0
#ra
##############################################################################

.data
a:            .space 36
titleRow:     .asciiz "Enter a row number:"
titleColumn:  .asciiz "Enter a column number:"
newLine1:     .asciiz "\n"
valueInput:   .asciiz "Enter either 0 or 1: "
x:            .asciiz " X "
slash:        .asciiz " | "
bottom:       .asciiz "----------------"
blank1:	      .asciiz "  "
zeroO:	      .asciiz " O "

.text
exitInput1:
rowup:
colup:
rowdn:
coldn:
exitInputlow:

jal newLine

jal nullReg
#################################################Storing the -1 in all index of array##############################
la $t0, a
addi $s7, $s7, -1
addi, $t1,$t1, 0
addi, $t2,$t2, 9
addi, $t4,$t4, -1
loop1:
beq $t1, $t2 exit1
sw $t4, 0($t0)
addi, $t1,$t1, 1
addi, $t0,$t0, 4
j loop1
exit1:

jal make
addi, $t6,$t6, 0
addi, $t7,$t7, 9
la $t0, a
loop2:
beq $t6, $t7 exit2
###############################################Row Input##########################################################
li $v0, 4
la $a0, titleRow
syscall
li $v0, 5
syscall
bgt $v0, 2, rowup
blt $v0, -1, rowdn
move $s1, $v0
#######################################Column Input##########################################################

li $v0, 4
la $a0, titleColumn
syscall

li $v0, 5
syscall
bgt $v0, 2, colup# Checking if column value is more than 2
blt $v0, -1, coldn# Checking if column value is less than 0
move $s2, $v0
beq $s1, $s7, terminate1# Checking row if it has value -1
terminate1:
beq $s2, $s7, terminate# Checking column if it has value -1
#######################################Formula impliptation##################################################
jal make
addi $t0, $t0, 3
addi $t1, $t1, 4
mul  $t4, $t0, $s1
add  $t4, $t4, $s2
mul  $t4, $t4, $t1
####################################0 or 1 Input############################################################
li $v0, 4
la $a0, valueInput
syscall

li $v0, 5
syscall
bgt $v0, 1, exitInput1# checking if the input is greater than 1
blt $v0, 0, exitInputlow# checking if the input is less than 0
move $s3, $v0

##################################Storing Input into array###############################################
move $t0, $zero
la $t0, a # base adress
add $t0, $t0,$t4 
sw $s3, 0($t0)

addi $t6,$t6, 1
j loop2

exit2:

jal terminateEcode# Printing Result with full entries
#####################################################################Terminate############################################################
terminate: 
jal terminateEcode# Printing Result if terminate

#################################################Functions######################################################
# to print the line
newLine:
li $v0, 4
la $a0, newLine1
syscall
jr $ra

make:

move $t0, $zero
move $t1, $zero
move $t2, $zero
move $t3, $zero
move $t4, $zero
jr $ra


bottomLine:
li $v0, 4
la $a0, bottom
syscall
jr $ra

slashLine:
move $s5, $zero
move $s6, $zero
addi $s6, $s6, 2
jr $ra

slashCode:
li $v0, 4
la $a0, slash
syscall
addi $s5, $s5, 1
jr $ra
terminateEcode:
move $t2, $zero
addi $t2, $t2, 3
move $t3, $zero
move $t4, $zero
move $t1, $zero

move $t0, $zero
la $t0, a 
move $t7, $zero
addi $t4, $t4, 2
jal slashLine

loop4:

beq $t1, $t2, exit4
lw $t7, 0($t0)
beq $t7, 1, exitfor1
beq $t7, 0, exitfor0
beq $t7, $s7, exitforneg1

exitfor1:
 
li $v0,4
la $a0, x
syscall
j loop5
exitfor0:
li $v0,4
la $a0, zeroO
syscall
j loop5
exitforneg1:

li $v0,4
la $a0, blank1
syscall
j loop5
loop5:

beq $s5, $s6, slashExit2
jal slashCode
addi $t1, $t1, 1
addi $t0, $t0, 4
j splash2
splash2:

j loop4
exit4:
slashExit2:
jal newLine
jal bottomLine
jal newLine
###########################################2Row####################################################################

move $t2, $zero
addi $t2, $t2, 6
move $t3, $zero
move $t4, $zero
move $t1, $zero
addi $t1, $t1, 3
move $t0, $zero
addi $s6, $s6, 2
la $t0, a 
move $t7, $zero
addi $t4, $t4, 2
jal slashLine
loop6:

beq $t1, $t2, exit5
lw $t7, 12($t0)
beq $t7, 1, exitfor11
beq $t7, 0, exitfor00
beq $t7, $s7, exitforneg11

exitfor11:
 
li $v0,4
la $a0, x
syscall
j loop7
exitfor00:
li $v0,4
la $a0, zeroO
syscall
j loop7
exitforneg11:

li $v0,4
la $a0, blank1
syscall
j loop7
loop7:
beq $s5, $s6, slashExit6
jal slashCode

addi $t1, $t1, 1
addi $t0, $t0, 4
j splash6
splash6:


j loop6
exit5:
slashExit6:
#######################################################3Row#################################################
jal newLine
jal bottomLine
jal newLine
jal slashLine
move $t2, $zero
addi $t2, $t2, 9
move $t3, $zero
move $t4, $zero
move $t1, $zero
addi $t1, $t1, 6
move $t0, $zero
la $t0, a 
move $t7, $zero
addi $t4, $t4, 2
loop9:

beq $t1, $t2, exit6
lw $t7, 24($t0)
beq $t7, 1, exitfor111
beq $t7, 0, exitfor000
beq $t7, $s7, exitforneg111

exitfor111:
 
li $v0,4
la $a0, x
syscall
j loop8
exitfor000:
li $v0,4
la $a0, zeroO
syscall
j loop8
exitforneg111:

li $v0,4
la $a0, blank1
syscall
j loop8
loop8:

beq $s5, $s6, slashExit3
jal slashCode
addi $t1, $t1, 1
addi $t0, $t0, 4
j splash3
splash3:

j loop9
exit6:
slashExit3:



li $v0, 10
syscall
jr $ra
nullReg:
move $t0, $zero
move $t1, $zero
move $t2, $zero
move $t3, $zero
move $t4, $zero
move $t5, $zero
move $t6, $zero
move $s0, $zero
move $s1, $zero
move $s2, $zero
move $s3, $zero
move $s4, $zero
move $s5, $zero
move $s6, $zero
move $s7, $zero
jr $ra