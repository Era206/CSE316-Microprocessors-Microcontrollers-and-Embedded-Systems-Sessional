.MODEL SMALL
.STACK 100H
.DATA
A DB 10,13,'THIS IS ON CENTER$'
B DB 10,13,'THIS IS ON 1ST QUARTANT$'
C DB 10,13,'THIS IS ON 2ND QUARTANT$'
D DB 10,13,'THIS IS ON 3RD QUARTANT$'
E DB 10,13,'THIS IS ON 4TH QUARTANT$'
F DB 10,13,'ON X AXIS$'
G DB 10,13,'ON Y AXIS$'
.CODE
MAIN PROC  
        MOV AX,@DATA
        MOV DS,AX
        
        ;INPUT TAKEN
        MOV AH,1 
        INT 21H
        MOV BL,AL 
        
        MOV AH,1 
        INT 21H
        MOV BH,AL
        
        MOV AH,1 
        INT 21H
        MOV CL,AL
        
        MOV AH,1 
        INT 21H
        MOV CH,AL
        
        
        
        CMP BX,'00'
        JE L1
        CMP BL,'0'
        JE L2
        JMP L7
        
        
        L1:
        CMP CX,'00'
        JE L3
        JMP L4 
               
        L2:
        CMP CX,'00'
        JE L5
        JMP L6 
        
        L3:
        MOV AH,9
        LEA DX,A
        INT 21H 
        JMP EXIT  
        
        L4:
        MOV AH,9
        LEA DX,G
        INT 21H 
        JMP EXIT 
        
        L5:
        MOV AH,9
        LEA DX,F
        INT 21H 
        JMP EXIT 
        
        L6: 
        CMP CL,'-'
        JE L15
        MOV AH,9
        LEA DX,B
        INT 21H 
        JMP EXIT
        
        L7:
        CMP CX,'00'
        JE L8
        JMP L9
        
        L8:
        MOV AH,9
        LEA DX,F
        INT 21H 
        JMP EXIT 
        
        L9:
        CMP CL,'0'
        JE L10
        JMP L11
        
        L10:
        MOV AH,9
        LEA DX,C
        INT 21H 
        JMP EXIT 
        
        L11: 
        ;CMP CL,'-'
        ;JE L13
        ;JMP L14
        
        ;L13:
        MOV AH,9
        LEA DX,D
        INT 21H 
        JMP EXIT 
        
        ;L14:
        ;MOV AH,9
        ;LEA DX,E
        ;INT 21H 
        ;JMP EXIT
        
        L15:
        MOV AH,9
        LEA DX,E
        INT 21H 
        JMP EXIT
         
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        EXIT:
        MOV AH,4CH
        INT 21H
        MAIN ENDP
END MAIN