TITLE Program 5		(prog5.asm)

; Author:					Nils Streedain
; Last Modified:			2/27/2022
; OSU email address:		streedan@oregonstate.edu
; Course number/section:	271-001
; Assignment Number:		5
; Due Date:					2/27/2022
; Description:				Write a MASM program to perform the tasks shown below. Be sure to test your program and ensure that it rejects incorrect input values.
;							Introduce the program.
;							Get a user request in the range [min = 15 .. max = 200].
;							Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements of an array.
;							Display the list of integers before sorting, 10 numbers per line.
;							Sort the list in descending order (i.e., largest first).
;							Calculate and display the median value, rounded to the nearest integer.
;							Display the sorted list, 10 numbers per line.

INCLUDE Irvine32.inc

; constants
MIN = 15
MAX = 200
LO = 100
HI = 999

.data
	; interface strings
	intro		BYTE		"Sorting Random Integers", 13, 10, "Programmed by Nils Streedain", 13, 10, "This program generates random numbers in the range [100 .. 999],", 13, 10, "displays the original list, sorts the list, and calculates the", 13, 10, "median value. Finally, it displays the list sorted in descending order.", 13, 10, "**EC: Random TA Name: Megan Black", 13, 10, 0
	prompt		BYTE		"How many numbers should be generated? [15 .. 200]: ", 0
	error		BYTE		"Invalid input", 13, 10, 0
	unsortTitle	BYTE		"The unsorted random numbers:", 10, 13, 0
	bye			BYTE		13, 10, "Thanks for using my program!", 0

	; program variables
	request		DWORD		?
	list		DWORD		MAX DUP(?)

.code
main PROC
	push	OFFSET intro
	call	introduction	; Prints the program title, author's name, & extra credit tag.
	
	push	OFFSET prompt
	push	OFFSET error
	push	OFFSET request
	call	getData			; Repeatedly prompts the user for a number until one is given in the range 1 to 300.

	mov		eax, request
	call	WriteDec
	
	push	OFFSET list
	push	request
	call	fillArray

	;call	sortList
	;call	displayMedian
	
	push	OFFSET list
	push	request
	push	OFFSET unsortTitle
	call	displayList

	push	OFFSET bye
	call	introduction			; tells the user goodbye
	exit							; exit to operating system
main ENDP

; Description:				Prints the program title, author's name, extra credit stats, & instructions
; Receives:					intro:		introduction string to print
; Returns:					N/A
; Preconditions:			intro must be defined
; Register changed:			edx
introduction PROC
	push	ebp
	mov		ebp, esp
	push	edx
	
	mov		edx, [ebp + 8]	; intro
	call	WriteString

	pop		edx
	pop		ebp
	ret		4
introduction ENDP

; Description:				Repeatedly prompts the user for a number until the user inputs a valid integer between 1-300
; Receives:					prompt:		prompt string used to ask user for number
; Returns:					N/A
; Preconditions:			prompt must be defined
; Register changed:			eax, edx
getData PROC
	push	ebp
	mov		ebp, esp
	pushad

promptUser:
	mov		edx, [ebp + 16]	; propmt string
	call	WriteString
	call	ReadInt

	cmp		eax, MIN		; validates the input number is between min & max
	jl		outOfRange		; if invalid, outOfRange is called
	cmp		eax, MAX
	jg		outOfRange
	jmp		valid
outOfRange:					; Gives the user an out of range error & then jumps to numPrompt to get another user input.
	mov		edx, [ebp + 12]	; error string
	call	WriteString
	jmp		promptUser
valid:						; Returns when a valid number is given by the user.
	mov		ebx, [ebp + 8]	; request int
	mov		[ebx], eax
	
	popad
	pop		ebp
	ret		12
getData ENDP

; Description:				
; Receives:					
; Returns:					
; Preconditions:			
; Register changed:			
fillArray PROC
	push	ebp
	mov		ebp, esp
	pushad
	
	mov		ecx, [ebp + 8]	; num times to loop
	mov		esi, [ebp + 12]	; list ref

fillLoop:
	mov		eax, HI
	sub		eax, LO
	inc		eax

	call	RandomRange
	add		eax, LO
	mov		[esi], eax
	add		esi, 4
	loop	fillLoop

	popad
	pop		ebp
	ret		8
fillArray ENDP

; Description:				
; Receives:					
; Returns:					
; Preconditions:			
; Register changed:			
displayList PROC
	push	ebp
	mov		ebp, esp
	pushad

	mov		edx, [ebp + 8]	; Print title
	call	WriteString

	mov		ebx, 0			; newline counter
	mov		ecx, [ebp + 12]	; num times to loop
	mov		esi, [ebp + 16]	; list ref

displayLoop:
	mov		eax, [esi]
	call	WriteDec

	mov		al, 9
	call	WriteChar

	inc		ebx
	cmp		ebx, 10
	jl		noNewLine
	call	Crlf
	mov		ebx, 0

noNewLine:
	add		esi, 4
	loop	displayLoop

	popad
	pop		ebp
	ret		12
displayList ENDP

END main
