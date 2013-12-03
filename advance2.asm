addi $1, $0, 1   ; mem[0]= 1
addi $7, $0, 2   ; mem[1]= 2
addi $6, $0, 20  ; c = 20
sw $1, 0($0)
sw $7, 4($0)
loop:            ; $3 -> i
lw $4, 0($3)     ; $4 -> a
lw $5, 4($3)     ; $5 -> b
addi $8, $3, 8   ; $8 = i+2
addi $4, $4, 2   ; a += 2
addi $5, $5, 1   ; b += 1
addi $3, $3, 4   ; i++
add $2, $2, $4   ; $2 = a
NOP
NOP
add $2, $2, $5   ; $2 += b, $2 = a + b
slt $9, $3, $6   ; cmp i, 20
NOP
sw $2, 0($8)     ; mem[i+2] = (a+b)
beq $9, $0, loop
