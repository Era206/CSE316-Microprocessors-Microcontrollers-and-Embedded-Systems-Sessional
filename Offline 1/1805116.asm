.MODEL SMALL
.STACK 100H
.DATA
ARR DW 100 DUP(?) 
MS1 DB 'ENTER ARRAY SIZE: $'
MS2 DB 'ENTER ARRAY ELEMENTS :',10,13,'$' 
MS3 DB 'ARRAY SIZE CANNOT BE NEGATIVE!', 10, 13,'$'
MS4 DB 'SORTED ARRAY USING INSERTION SORT: ',10,13,'$'
MSG DB "ENTER A NUMBER: $"
MSG1 DW 'FOUND IT IN POSITION : $'
MSG2 DW 'NOT FOUND ',10,13,'$'
SIZE DW ?
BEGIN DW ? 
LAST DW ?
MID DW ? 
TOTAL DW 0
VALUE DW 0   
FLAG DW 0 
C DW ?
B DW ?
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX 
    
    ARRAY:
    
    MOV AH, 9
    LEA DX, MS1
    INT 21H  
    MOV FLAG,0 
    MOV TOTAL,0
    MOV VALUE,0
    
    READSIZE:
    MOV AH,1
    INT 21H
    
    CMP AL, 13
    JE ENDOFSIZE
    CMP AL,'-'
    JE NEGATIVE
    MOV AH,0
    
    MOV VALUE, AX
    SUB VALUE, '0'
    
    MOV AX, TOTAL
    MOV BL, 10
    MUL BL
    
    ADD AX, VALUE
    
    MOV TOTAL, AX
    
    JMP READSIZE  
    
    NEGATIVE:
    MOV FLAG,1
    JMP READSIZE
    
    ENDOFSIZE: 
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H 
    CMP FLAG,1
    JE ERROREXIT
    MOV AX,TOTAL
    MOV SIZE,AX
    
    
    ;THIS PART WILL TAKE ARRAY INPUT AND PUT IT IN ARRAY
    MOV AH, 9
    LEA DX, MS2
    INT 21H
    LEA SI,ARR
    
    MOV CX,SIZE
    ARRAYINPUT:
    MOV AX,0
    MOV BX,0
    MOV TOTAL,0
    MOV VALUE,0
    MOV FLAG,0
    
    READ:
    MOV AH,1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER 
    CMP AL,'-'
    JE NEGATIVEARRAY
    MOV AH,0
    
    MOV VALUE, AX
    SUB VALUE, '0'
    
    MOV AX, TOTAL
    MOV BL, 10
    MUL BL
    
    ADD AX, VALUE
    
    MOV TOTAL, AX
    
    JMP READ 
    
    NEGATIVEARRAY:
    MOV FLAG,1
    JMP READ

    ENDOFNUMBER:
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H 
    CMP FLAG,1
    JE NEGATE
    
    MOV AX,TOTAL
    MOV [SI],AX
    ADD SI,2 
    JMP ARRAYLOOP
    
    NEGATE:
    NEG TOTAL
    MOV AX,TOTAL
    MOV [SI],AX
    ADD SI,2  
    ARRAYLOOP:
    LOOP ARRAYINPUT   
    
       MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H
               
               
    ;ARRAYSORTING PART 
     LEA SI,ARR
    
    MOV CX,SIZE
    SUB CX,1 
    MOV DX,0
    MOV BX,2
    
    LOOP1:
    MOV FLAG,CX
    MOV AX,[SI+BX]
    MOV B,BX 
    SUB BX,2
    WHILE:
    CMP BX,0
    JL LOOP2
    CMP [SI+BX],AX
    JLE LOOP2 
    
    MOV CX,[SI+BX]
    MOV [SI+BX+2],CX 
    SUB BX,2
    JMP WHILE
    
    LOOP2:
    MOV [SI+BX+2],AX
    MOV BX,B
    ADD BX,2
    MOV CX,FLAG
    LOOP LOOP1  
    
  
    ;THIS PART WILL PRINT THE ARRAY 
    MOV AH,9
    LEA DX,MS4
    INT 21H
    
    MOV CX,SIZE 
    LEA SI,ARR
    PRINT:
    MOV FLAG,CX
    
    MOV BX, 10    
    MOV DX, 0    
    MOV CX, 0    
    MOV AX,[SI] 
    CMP AX,0
    JL NEGATIVE1
    JMP .DLOOP1
    
    NEGATIVE1: 
    MOV TOTAL,AX
    MOV AH,2
    MOV DL,'-'
    INT 21H
    MOV AX,TOTAL
    NEG AX
    
            
   .Dloop1:  
       MOV DX, 0    
       div BX      
       PUSH DX     
       INC CX     
       CMP AX, 0    
       JNE .Dloop1     
    
    .Dloop2:  
       POP DX     
       ADD DX, '0'    
       MOV AH, 2     
       INT 21H      
       LOOP .Dloop2    
       
       MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H  
       
    ADD SI,2
    MOV CX,FLAG
    LOOP PRINT 
    
    LEA SI,ARR
     
    BINARYSEARCH:
    
     ;TAKING INPUT FOR BINARY SEARCH 
     MOV AH, 9
    LEA DX, MSG
    INT 21H
     MOV TOTAL,0
     MOV VALUE,0 
     MOV FLAG,0
    READ2: 
    
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE ENDOFNUMBER2 
    CMP AL,'-'
    JE NEGATIVE3
    MOV AH,0
    
    MOV VALUE, AX
    SUB VALUE, '0'
     
    
    MOV AX, TOTAL
    MOV BL, 10
    MUL BL
    
    ADD AX, VALUE
    
    MOV TOTAL, AX
    
    JMP READ2 
    
    NEGATIVE3:
    MOV FLAG,1
    JMP READ2
    
    ENDOFNUMBER2:
    CMP FLAG,1
    JNE BS
    NEG TOTAL
    
    BS:
    LEA SI,ARR
    ;MOV CX,5
    MOV CX,SIZE
    ADD CX,SIZE
    SUB CX,2 
    MOV BEGIN,0
    MOV LAST,CX
    MOV FLAG,CX
    MOV MID,0
    
    WHILE2:
    MOV CX,LAST 
    CMP BEGIN,CX
    JG L1
    MOV AX,BEGIN
    ADD AX,LAST
    MOV BL,4
    DIV BL
    MOV AH,0
    ;SUB AX,2
    MOV BL,2
    MUL BL
    MOV AH,0  
    MOV C,AX
    MOV MID,AX 
    MOV BX,MID 
    MOV CX,TOTAL
    CMP [SI+BX],CX
    JL L2 
    JG L3
    JMP L4
    
    L1:
    MOV CX,FLAG
    MOV MID,CX
    ADD MID,2
    JMP DECISION
    L2:
    MOV CX,MID
    MOV BEGIN,CX
    ADD BEGIN,2
    JMP WHILE2
    L3: 
    MOV CX,MID
    MOV LAST,CX
    SUB LAST,2
    JMP WHILE2
    L4:
    JMP DECISION
   ; LOOP LOOP1  
   
   DECISION:
   MOV AH,2
   MOV DL,10
   INT 21H
   MOV DL,13
   INT 21H
    
   MOV CX,FLAG
   CMP MID,CX
   JG NOTFOUND
   MOV AH,9
   LEA DX,MSG1
   INT 21H 
   
    ;PRINT THE SERIAL
    MOV BX, 10     
    ;MOV DX, 0    
    MOV CX, 0     
    MOV AX,MID
    MOV DL,2
    DIV DL
    MOV AH,0
    MOV DX,0
    ADD AX,1 
    
    
          
   Lp1:  
       MOV DX, 0    
       div BX      
       PUSH DX     
       INC CX      
       CMP AX, 0     
       JNE Lp1    
    
    Lp2:  
       POP DX      
       ADD DX, '0'     
       MOV AH, 2     
       INT 21H      
       LOOP Lp2     
       
       MOV AH,2
       MOV DL,10
       INT 21H
       MOV DL,13
       INT 21H 
   JMP  BINARYSEARCH
   
   NOTFOUND:
   MOV AH,9
   LEA DX,MSG2
   INT 21H  
   JMP  BINARYSEARCH 
   
   ERROREXIT: 
   MOV AH,9 
   LEA DX,MS3
   INT 21H
   ;JMP ARRAY
   
   MOV AH,4CH
   INT 21H
   MAIN ENDP
   END MAIN
   
   
       
    
    
