Title	Assignment 1 

;Daniel J. Gonzalez
;gonzald3@oregonstate.edu
;CS271-400
;Assignment #1
;1.21.2018


include	Irvine32.inc

.data
number1			dword	?		;the first user-number (? means uninitialized)
number2			dword	?		;the second user-number
introprog		byte	"-------Elementary Arithmetic by Daniel	J Gonzalez-------", 0
intro			byte	"Enter 2 numbers, and I'll show you the sum, ",
						13, 10, "product, quotient, and remainder.", 0	;13, 10, creates a new-line
input1			byte	"First #: ", 0
input2			byte	"Second #: ", 0
totalSum		dword	?			;to store the results
totalDif		dword	?			;to store the results
totalMul		dword	?			;to store the results
totalQuo		dword	?			;to store the results
totalRem		dword	?			;to store the results
sumString		byte	" + ", 0
difString		byte	" - ", 0
mulString		byte	" x ", 0
quoString		byte	" / ", 0
remString		byte	" remainder ", 0
equalString		byte	" = ", 0
EC1string		byte	"**EC:	Program verifies second number is less than first.", 0
EC1error		byte	"**EC:	The second number must be less than the first!" ,13,10, 0
EC2string		byte	"**EC:	Program repeats until the user chooses to quit.", 0
EC2cont			byte	"If you would like to try again press 0 or [ENTER]...", 13, 10, 0   ;13, 10, creates a new-line 
EC3String		byte	"**EC:	Program calculates and displays the quotient as a floating-point",
								13, 10, ",rounded to the nearest .001", 0
EC3float		REAL4	?	;REAL4 type reserves space for floating-point
ECloop			dword	?	;intitalize number for loop/continue test
Goodbye			byte	"Impressed? Bye!", 0
.code
main PROC

;Display your name and program title on the output screen
	mov		edx, OFFSET	introprog			;stores the string into the edx location
	call	WriteString						;outputs string
	call	Crlf	;carry return line feed

;Display ExtrCredit Output
	mov		edx, OFFSET	EC1String		;stores the string into the edx register
	call	WriteString					;outputs string
	call	Crlf

;Display ExtraCredit Output2
	mov		edx, OFFSET EC2String		;stores the string into the edx register
	call	WriteString					;outputs string
	call	Crlf

;Display instructions for the user
	mov		edx, OFFSET intro	;need OFFSET because edx requires address
	call	WriteString
	call	Crlf	;carry return line feed


beginning:	;label created for looping and testing second number is less than first number

;Prompt the user to enter two numbers.
	mov		edx, OFFSET	input1	;prepares the "First #: " string in edx
	call	WriteString			;prints the menu
	call	ReadInt				;waits for user input + enter key
	mov		number1, eax		;stores the user input into variable number1
	mov		edx, OFFSET	input2	;prepares the "Second #: " string in edx
	call	WriteString			;prints the menu
	call	ReadInt				;waits for the user input + the enter key
	mov		number2, eax		;stores the user input into variable number2
	call	Crlf

;ExtraCredit Compare
	mov		eax, number1
	cmp		eax, number2		;compares number1 and number2	
	;conditions below (if compare moves to jl and the second# is greated than the first jump to error)
	jl		Error		;jumps if true						
	jmp		Calculations	;skips error by jumping if jl test is false

Error:		;label created for extracredit compare & possible jump
		mov		edx, OFFSET	EC1error		;moves string to edx register
		call	WriteString					;outputs string
		jmp		beginning					;jumps to beginning because second value is not acceptable for EC1
	
Calculations:
;Calculate the sum, difference, product, (integer) quotient and remainder of the numbers.
	;sum
	mov		eax, number1		;stores number1 in eax
	mov		ebx, number2		;stores number2 in ebx
	add		eax, ebx			;stores the addition of eax and ebx into eax
	mov		totalSum, eax		;moves the sum in eax to the variable totalSum
	;difference
	mov		eax, number1		;stores number1 in eax
	mov		ebx, number2		;stores number2 in ebx
	sub		eax, ebx			;stores the sum of eax and ebx into eax
	mov		totalDif, eax		;moves contents of eax into the variable totalDif
	;product
	mov		eax, number1		;stores number1 in eax
	mov		ebx, number2		;stores number2 in eax
	mul		ebx					;note default location for mul is eax, that the reason for one operand
	mov		totalMul, eax		;moves contents of eax into variable totaMul
	;quotient
	mov		eax, number1		;stores number1 in eax
	mov		ebx, number2		;stores number2 in ebx
	mov		edx, 0				;intialized edx to 0
	div		ebx					;note eax is the default location for DIV and MUL so only one operand is needed
	mov		totalQuo, eax		;stores contents of eax into totalQuo
	mov		totalRem, edx		;in 32-bit eax is the quotient and edx is the remainder (store the remainder in the remainder variable

;Report the result
	;sum
	mov		eax	, number1			;to print result as integer mov value of integer into eax
	call	WriteDec				;to write decimal to standard output in decimal form
	mov		edx, OFFSET	sumstring	;print the + symbol
	call	WriteString
	mov		eax, number2			
	call	WriteDec
	mov		edx, OFFSET	equalString	;print = sign
	call	WriteString
	mov		eax, totalSum		;prints result
	call	WriteDec
	call	Crlf
	;difference
	mov		eax, number1		;prepared the decimal for the next call
	call	WriteDec			;prints the Decimal value of number1	
	mov		edx, OFFSET	difString	;prepares the " - " symbol
	call	WriteString
	mov		eax, number2
	call	WriteDec		;prints the decimal
	mov		edx, OFFSET	equalString		;prepares the equal string
	call	WriteString	
	mov		eax, totalDif
	call	WriteDec
	call	Crlf
	;product
	mov		eax, number1	;prepares the decimal for the call to write
	call	WriteDec		;writeDec outputs number in decimal format
	mov		edx, OFFSET mulString	;prepares " x " by storing it in edx 
	call	WriteString				;prints the " x " string
	mov		eax, number2	;prepares the decimal for the call to write
	call	WriteDec		;prints the number2 in decimal format
	mov		edx, OFFSET	equalString	;prepares the ' = ' in edx
	call	WriteString				;prints the ' = ' to the screen
	mov		eax, totalMul			;prepared the total in eax because it is a decimal
	call	WriteDec
	call	Crlf
	;quotient and remainder
	mov		eax, number1	;prepares number1 on eax
	call	WriteDec		;print in decmial format number1 in eax
	mov		edx, OFFSET quoString	;moves " / " into edx
	call	WriteString				;prints " / " string
	mov		eax, number2	;prepared num2 on eax
	call	WriteDec		;prints in decimal format num2 in eax
	mov		edx, OFFSET equalString	;prepares " = " in edx
	call	WriteString				;prints " = " to screen
	mov		eax, totalQuo	;prepared totalQuo in eax 
	call	WriteDec		;print in decimal format the eax contents or totalQuo
	mov		edx, OFFSET remString	;prepares " remainder " string for the next call
	call	WriteString				;writes the contents of edx " remainder "
	mov		eax, totalRem			;moves total Rem into eax
	call	WriteDec				;prints the remainder
	call	Crlf

;Extra-Credit Loop
	mov		edx, OFFSET EC2Cont
	call	WriteString
	call	ReadInt			;waits until the user inputs a number and presses enter
	mov		ECloop, eax		;move the contents of the user-input (which is stored in eax by default) to ECloop variable
	cmp		ECloop, 0		;compare the value with 0 (0 means continue)
	je		beginning				;je is the jump if equal mnemonic (thus if 0 is pressed jump to beginning)

;Display a terminating message
	mov		edx, OFFSET Goodbye
	call	WriteString
	call	Crlf

exit	;exit to operating system
main ENDP
END	main