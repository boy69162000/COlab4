addi $1, $0, 1
addi $7, $0, 2
addi $6, $0, 20
sw $1, 0($0)
sw $7, 4($0)
loop:
lw $4, 0($3)
lw $5, 4($3)
addi $8, $3, 8
addi $4, $4, 2
addi $5, $5, 1
addi $3, $3, 4
add $2, $2, $4
NOP
NOP
add $2, $2, $5
slt $9, $3, $6
NOP
sw $2, 0($8)
beq $9, $0, loop