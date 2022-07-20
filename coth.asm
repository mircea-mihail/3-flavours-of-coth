;nasm -f elf64 -o coth.o coth.asm 	# assemble the program  
;gcc -m64 -o -no-pie coth coth.o				# link the object file nasm produced into an executable file  
;./coth 							# hello is an executable file 

;QUAD MEANS DOUBLE SO LONG FLOAT!!!

section .bss
	x resq 1

section .data
	;x dq 1.0
	border dq 2.9
	counter db 0
	counter1 dq 0.0
	final_sum dq 0.0
	prod1 dq 0.0
	prod2 dq 0.0

	basic_read db "%lf", 0
	var_ask db "coth(x)", 10, "choose an x: ", 0
	chosen_var db 10, "%lf has been read", 10, 0 
	checker db 10, "the final approximation is %lf", 10, 0

	one dq 1.0
	two dq 2.0
	pi dq 3.141592
	iterations db 99

section .text
	global main

	extern printf
	extern scanf

	main:
		push rbp
		mov rbp, rsp

		;var reading message

		mov rdi, var_ask
		mov rax, 0
		call printf

		;scanning the read var
		mov rdi, basic_read
		mov rsi, x
		xor eax, eax
		call scanf
		
		;printing the var
		movsd xmm0, [x]
		mov rdi, chosen_var
		mov rax, 1
		call printf


		;making the first division
		movsd xmm0, [one]
		divsd xmm0, [x]	
		movsd [final_sum], xmm0	

		;checking if greater than 2.9
		xor rax, rax
		xor rbx, rbx
		mov rax, [x]
		mov rbx, [border]
		cmp rax, rbx
		jg appone

		loop:
			;setting up the counter
			inc byte [counter]

			movsd xmm0, [counter1]
			addsd xmm0, [one]	
			movsd [counter1], xmm0

			;prod1 = 2*x
			movsd xmm0, [two]
			mulsd xmm0, [x]	
			movsd [prod1], xmm0

			;prod2 = pi*pi*counter*counter
			movsd xmm0, [pi]
			mulsd xmm0, [pi]
			mulsd xmm0, [counter1]
			mulsd xmm0, [counter1] 	
			movsd [prod2], xmm0
		
			;prod2 = (pi*pi*i*i + x*x)
			movsd xmm0, [x]
			mulsd xmm0, [x]
			addsd xmm0, [prod2]
			movsd [prod2], xmm0

			;final_sum += prod1/prod2
			movsd xmm0, [prod1]
			divsd xmm0, [prod2]
			addsd xmm0, [final_sum] 
			movsd [final_sum], xmm0
		
			xor eax, eax
			mov al, [counter]
			mov ah, [iterations]
			cmp al, ah
			jne loop
		;loop sequence end

		;final sum print
		movsd xmm0, [final_sum]
		mov rdi, checker
		mov rax, 1
		call printf
		xor rax, rax
		cmp rax, rax
		je end

		appone:
			movsd xmm0, [one]
			mov rdi, checker
			mov rax, 1
			call printf
			xor rax, rax
			cmp rax, rax
			je end

		end:
		pop rbp 	;seg fault without it
		mov rax, 60 ;60 == exit
		mov rdi, 0	;exit code
		syscall