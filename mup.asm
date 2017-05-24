#make_bin#

;; es and ds have to be the same bcoz i m using movsb
;; count1 , count2 count3 count4 count5 count6 count7 count8,    
;; functions to make Presiding_officer_keypad , 
;; have to make A i's 0 after every poll
;; overflow problem keypad
;; memory to map : presiding_pwd ,   somewhere db , a db 5 dup(0)
;; initialize code for 8259b
;; check ocw for 8259b and a
#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0200h#
#SP=0FFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#

; Necessary Initialisation
;;8255
led_porta equ 00h
led_portb equ 02h
led_portc equ 04h
led_creg  equ 06h


;;8255
officer_porta equ 08h
officer_portb equ 0Ah
officer_portc equ 0Ch
officer_creg  equ 0Eh


;;8259
cand_icw1 equ 10h
cand_icw2 equ 12h
cand_icw4 equ 12h
cand_ocw1 equ 12h
cand_ocw2 equ 12h

;;8259 polling officer interrupts

poll_icw1 equ 14h
poll_icw2 equ 16h
poll_icw4 equ 16h
poll_ocw1 equ 16h
poll_ocw2 equ 16h


;; 8253  -10 hour counter
timer_cnt0 equ 18h
timer_cnt1 equ 1Ah
timer_cnt2 equ 1Ch
timer_creg equ 1Eh


; This Should Be The Line Pointed By The Magic Number
         jmp     start
         db 509 dup(0)
; The Instructions Above Consume A Memory Of Total Of 512 Kb
; 3 Bytes For The jmp start And 509 Bytes Reserved By The Memory

; The Interrupt Vector Table Actually Starts Here
; IVT entry for 80H

    dw isr0
    dw 0000

    dw isr1
    dw 0000

    dw isr2
    dw 0000
   
    dw isr3
    dw 0000
   
    dw isr4
    dw 0000
   
    dw isr5
    dw 0000
   
    dw isr6
    dw 0000
   
    dw isr7
    dw 0000
   
    db 32 dup(0)
   
    dw isr_lock
    dw 0000
   
    dw isr_unlock
    dw 0000
   
    dw isr_poll_count
    dw 0000
   
    dw isr_display_count
    dw 0000
   
    db 432 dup(0)
   
    ; INterrupts starting form 80h-87h for candidate buttons
    ; Interrrupts for presiding officer range from 90h-93h
    ; We also clear the next 432 bytes of memory as they were the part of IVT.

    ; Next, we start taking the memory locations to be used by our passwords

  password1 db '12345'
  password2 db '23456'
  password3 db '34567'
  password4 db '45678'
  password5 db '56789'
  password6 db '67890'
  password7 db '78901'
  password8 db '89012
  password_main db '90123'
  
   
; Main Program Starts Here

start:
    cli
    ; Clear The Interrupts While Setting Up The Stack And Other Registers
   
    ; Intialize ds, es,ss To Start Of RAM
   
          mov       ax,01000h
          mov       ds,ax
          mov       es,ax
          mov       ss,ax
          mov       sp,0FFEh

    ; Setting up the variable
    count1 dw 0
    count2 dw 0
    count3 dw 0
    count4 dw 0
    count5 dw 0
    count6 dw 0
    count7 dw 0
    count8 dw 0
    total_counts dw 0
    
    officer1 db 'officer1'
    officer2 db 'officer2'
    officer3 db 'officer3'
    officer4 db 'officer4'
    officer5 db 'officer5'
    officer6 db 'officer6'
    officer7 db 'officer7'
    officer8 db 'officer8'
    pofficer db 'pofficer'

    temp  db 0 
    temp1 db 0
    temp2 db 0
    temp3 db 0

    ;String for storing passwords temporarily
    a db 5 dup(0)
   
;; led  8255 initialising
   
    ;Checks if all the vote memory are empty and replaces them with 0 if not
    call empty_check;

    ;Initialize all the ICs
    call init_8255a
    call inti_8255b
    call init_8259a
    call init_8259b
    call init_8253

    














   ;check if memory is empty
empty_check proc near
      mov ax,0
      lea si, count1
      mov [si], ax
      lea si, count2
      mov [si], ax
      lea si, count3
      mov [si], ax
      lea si, count4
      mov [si], ax
      lea si, count5
      mov [si], ax
      lea si, count6
      mov [si], ax
      lea si, count7
      mov [si], ax
      lea si, count8
      mov [si], ax
      lea si, total_count
      mov [si], ax
RET
empty_check ENDP




isr0:     lea si, count0
    mov ax,[si]
    inc ax
    mov [si],ax

iret


isr1:     lea si, count1
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr2:     lea si, count2
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr3:     lea si, count3
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr4:     lea si, count4
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr5:     lea si, count5
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr6:     lea si, count6
    mov ax,[si]
    inc ax
    mov [si],ax

iret

isr7:     lea si, count7
    mov ax,[si]
    inc ax
    mov [si],ax

iret





init_8255a proc near
    mov led_creg, 10001011b
RET
init_8255a ENDP




init_8255b proc near
    mov officer_creg,10000001b   
RET
init_8255b ENDP


init_8259a proc near
    mov cand_icw1,00010011b
    mov cand_icw2,10000000b
    mov cand_icw4,000000011b
RET
init_8259a ENDP


init_8259b proc near ;;;;;;;;;;;;;;;;;;;;
    mov poll_icw2,
RET
init_8259b ENDP


init_8253 proc near
    mov al,00110000b
    out timer_creg,al
    mov al, 50h
    out timer_cnt0,al
    mov al,c3h
    out timer_cnt0,al
   
    mov al,01110000b
    out timer_creg,al
    mov al, 70h
    out timer_cnt1,al
    mov al,17h
    out timer_cnt1,al
   
    mov al,10110000b
    out timer_creg,al
    mov al, 58h
    out timer_cnt0,al
    mov al,02h
    out timer_cnt0,al
RET
init_8253 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;old cand code
CHECK_KEY proc near
    ;; checking if a key is pressed
    pusha
    mov cx,8
    IN AL, PORTB
    CMP AL,0h
    JE __do_nothing
    call GLOW_LED
    call COUNTER_INC
    __do_nothing:
    popa
RET
CHECK_KEY ENDP

GLOW_LED proc near
    ;; AX stores which led to glow
    OUT PORTA,AL
    DELAY_2s
    MOV AL,00h
    OUT PORTA,AL
RET
GLOW_LED ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;old cand code


COUNTER_INC proc near
     ;; increment relevant counter
    mov ah,100h
    mov ds,ah
    mov cx,0h
   
    __rol_rt :   ;;; checking which count needs to be incremented
        ror
    jnz __outside
    inc CX
    jmp __rol_rt
    __outside:
    mov si,cx
   
   
    mov bx,ax        ;; changing ds to 0100h using ax register... dont want to lose initial value of ax so copying it first to bx
    mov ax,0100h
    mov ds,ax
    mov ax,bx
   
   
    mov bx,[si]   
    inc bx
    mov [si],bx
RET
COUNTER_INC ENDP
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;old counter code


DELAY_1ms proc near ;;delay 1ms

    pusha
    MOV CX,03h
    MOV DX,0E8h
    MOV AH,86h
    INT 15h
    popa
RET
DELAY_1ms ENDP

DELAY_50ms proc near ;; delay 50ms
    pusha
    MOV CX,0C3h
    MOV DX,50h
    MOV AH,86h
    INT 15h
    popa
RET
DELAY_50ms ENDP

DELAY_1s proc near
    pusha
    mov CX,20
    __delay1s:call DELAY_50ms   ;; delaying 50ms - 20 times
        LOOP __delay1s
   
    popa
RET
DELAY_1s ENDP

DELAY_2s proc near ;; delaying 2s by calling 1s funciton 2 times
    pusha
    call DELAY_1s
    call DELAY_1s
    popa
RET
DELAY_2s ENDP



DELAY_20ms proc near
    pusha
    mov CX,20
    __delay1ms:call DELAY_1ms   ;;delaying 20 ms by delaying 1 ms 20 times
        LOOP __delay1ms
   
    popa
RET
DELAY_20ms ENDP



isr_lock proc near
    call Presiding_officer_keypad
    CMP AX,presiding
IRET
isr_lock ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;to be checked
take_inputs proc near
    PUSHA
    MOV AX,0
    MOV DX,0
  __enter:    call keypad
          CMP AL,0Bh
          JE __output_lastline
       
        CMP AL,0Ah
        JNE __normal_input
        call shift_left
        JMP __enter
       
  __normal_input: call shift_right
          LEA DI,a
          mov [DI],AL       
       
        JMP __enter

 __output_lastline:
     POPA
 
RET
take_inputs ENDP




shift_left proc near
   PUSHA
   LEA DI,a
   LEA SI,a
   INC SI
   MOVSB  ;;a[0]=a[1]
   INC SI
   INC DI
   MOVSB  ;;a[1]=a[2]
   INC SI
   INC DI
   MOVSB  ;;a[2] =a[3]
   INC SI
   INC DI
   MOVSB  ;;a[3] = a[4]
   INC DI
   MOV AL,0
   MOV [DI],AL ;;[a4]=0
   POPA
RET
shift_left ENDP


shift_right proc near
   PUSHA
   LEA DI,a
   LEA SI,a
   ADD DI,4
   ADD SI,3
  
   MOVSB ;;a[4]=a[3]
   DEC SI
   DEC DI
   MOVSB ;;a[3]=a[2]
  
   DEC SI
   DEC DI
   MOVSB ;;a[2]=a[1]
  
   DEC SI
   DEC DI
   MOVSB ;;a[1]=a[0]
  
   DEC DI
   MOV AL,0
   MOV [DI],AL ;;a[0]=0
   
   POPA
RET
shift_right ENDP

keypad proc near
    PUSHA
    X0: MOV AL,00h
            OUT officer_portc,AL
       
        X1: IN AL,04h   ;;;; debounce
            AND AL,F0h
            CMP AL,F0h
            JNZ X1
        CALL DELAY_20ms
                       
           
            MOV AL,00h
            OUT officer_portc,AL
        X2: IN AL,04h   ;;;; check for key press
            AND AL,F0h
            CMP AL,F0h
            JNZ X2
        CALL DELAY_20ms
       
            MOV AL,00h
            OUT officer_portc,AL
        X2: IN AL,04h   ;;;; check for key press
            AND AL,F0h
            CMP AL,F0h
            JNZ X2
        CALL DELAY_20ms
       
       
        MOV AL, 0EH
        MOV BL,AL
        OUT officer_portc,AL  ;; column1
        IN AL,04H
        AND AL,F0H
        CMP AL,F0H
        JNZ X3
       
       
        MOV AL, 0DH
        MOV BL,AL
        OUT officer_portc,AL ;; column2
        IN AL,04H
        AND AL,F0H
        CMP AL,F0H
        JNZ X3
       
        MOV AL, 0BH
        MOV BL,AL
        OUT officer_portc,AL ;;column3
        IN AL,04H
        AND AL,F0H
        CMP AL,F0H
        JNZ X3
       
        MOV AL, 07H
        MOV BL,AL
        OUT officer_portc,AL ;;column4
        IN AL,04H
        AND AL,F0H
        CMP AL,F0H
        JNZ X3
       
       X3 : OR AL,BL   ;;
            MOV CX,0FH
            MOV DI,00h
           
        X4: CMP AL,TABLE_K[DI]
            JNZ X5
            INC DI
            LOOP X4
        MOV AL,DI
         mov somewhere,AL
         POPA
         MOV AL,somewhere
RET
keypad ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;to be checked

;;Code for displaying Officer1 on the display
;;Check for Keyboard Inputs, take 5 inputs and compare with password1
;;If not correct, take 5 bits again and compare
;;Exit the program if this happens again
;;If correct, display officer 2
;;;;;;;;;;;;;;;;;;;