.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER A NUMBER: $"
MSG2 DB "ENTER ANOTHER NUMBER: $" 
ARR DW 100 DUP(?)
TOTAL1 DW 0  
TOTAL2 DW 0 
GCD DW ?
VALUE DW 0 
FLAG DW 0  
COUNT DW 0
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX 
    
    INPUT:
    
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
    LEA SI,ARR
    MOV CX,TOTAL1
    SUB CX,1 
 
    ARRAYINPUT:
    CMP CX,1
    JE ARRAYOUT
    MOV [SI],CX
    ADD SI,2 
    LOOP ARRAYINPUT
    
    ARRAYOUT:  
    LEA SI,ARR
    MOV CX,TOTAL1
    SUB CX,2
    CHECKLOOP:
   
     
    
    
    MOV AX,TOTAL1
    MOV BX,[SI]
    
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
    MOV GCD,1 
    ADD SI,2 
    ENDLOOP:
    CMP GCD,1
    JE COUNTLEVEL
    ENDLOOP2:
    LOOP CHECKLOOP
    JMP PRINT 
    COUNTLEVEL:
    ADD COUNT,1
    JMP ENDLOOP2
     
    
    
    
    
    
    
    PRINT:
    
       MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H 
  
       MOV BX, 10     ;Initializes divisor
       MOV DX, 0    ;Clears DX
       MOV CX, 0   ;Clears CX 
       
       MOV AX,COUNT
      
      
       
    
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