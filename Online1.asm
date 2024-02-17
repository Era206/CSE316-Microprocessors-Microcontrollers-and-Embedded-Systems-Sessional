.MODEL SMALL
.STACK 100H
.DATA
 A DB 'INPUT CAPITAL LETTER $'
 B DB 10,13,'ASKED SMALL LETTER $'

 
 .CODE
 MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,9
    LEA DX, A
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV BL, AL
    
    
    SMALL:
    MOV AH,9
    LEA DX,C
    INT 21H
    
    CMP BL,BH
    JG L1
    JMP L2
    
    L1:
    MOV AH,2
    MOV DL,BL
    INT 21H
    JMP EXIT
    
    L2:
    MOV AH,2
    MOV DL,BH
    INT 21H
    JMP EXIT
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
 END MAIN