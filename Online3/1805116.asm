.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER A NUMBER: $"
MSG2 DB "ENTER ANOTHER NUMBER: $"
TOTAL1 DW 0  
TOTAL2 DW 0 
GCD DW ?
VALUE DW 0 
FLAG DW 0
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX 
    
    GCDCHECK:
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    READ:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER1 
    MOV AH,0
    
    MOV VALUE, AX
    SUB VALUE, '0'
    
    MOV AX, TOTAL1
    MOV BL, 10
    MUL BL
    
    ADD AX, VALUE
    
    MOV TOTAL1, AX
    
    JMP READ 
    ENDOFNUMBER1:  
     MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H 
       
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    READ2:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER2 
    MOV AH,0
    
    MOV VALUE, AX
    SUB VALUE, '0'
    
    MOV AX, TOTAL2
    MOV BL, 10
    MUL BL
    
    ADD AX, VALUE
    
    MOV TOTAL2, AX
    
    JMP READ2
    
    ENDOFNUMBER2:
    MOV AX,TOTAL1
    MOV BX,TOTAL2
    
    GCDLOOP1:
    CMP AX,BX
    JE GCDLOOPOUT
    JG GCDLEVEL1
    SUB BX,AX 
    JMP GCDLOOP1
    
    GCDLEVEL1:
    SUB AX,BX
    JMP GCDLOOP1
    
    GCDLOOPOUT:
    MOV GCD,AX
    
    
    
    PRINT:
    
       MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H 
  
       MOV BX, 10     ;Initializes divisor
       MOV DX, 0    ;Clears DX
       MOV CX, 0   ;Clears CX 
       
       MOV AX,GCD
      
      
       
    
          ;Splitting process starts here
   .Dloop1:  
       MOV DX, 0    ;Clears DX during jump
       div BX      ;Divides AX by BX
       PUSH DX     ;Pushes DX(remainder) to stack
       INC CX      ;Increments counter to track the number of digits
       CMP AX, 0     ;Checks if there is still something in AX to divide
       JNE .Dloop1     ;Jumps if AX is not zero
    
    .Dloop2:  
       POP DX      ;Pops from stack to DX
       ADD DX, '0'     ;Converts to it's ASCII equivalent
       MOV AH, 2     
       INT 21H      ;calls DOS to display character
       LOOP .Dloop2    ;Loops till CX equals zero
       
      

MAIN ENDP