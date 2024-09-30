bits 64

global _start

; Syscall number
; rax
; Syscall parameters
; rdi rsi rdx

_start:

	; Socket
	mov rdi, AF_INET
	mov rsi, SOCK_STREAM
	mov rdx, 0
	mov rax, SYS_SOCKET
	syscall
	mov r8, rax

	; Bind
	mov rdi, r8
	mov rsi, sockaddr
	mov rdx, end_sockaddr - sockaddr
	mov rax, SYS_BIND
	syscall

	; Listen
	mov rdi, r8
	mov rsi, BACKLOG
	mov rax, SYS_LISTEN
	syscall

loop:
	; Accept
	mov rdi, r8
	mov rsi, 0
	mov rdx, 0
	mov rax, SYS_ACCEPT
	syscall
	mov r9, rax

	; Write
	mov rdi, r9
	mov rsi, message
	mov rdx, end_message - message
	mov rax, SYS_WRITE
	syscall

	; Close
	mov rdi, r9
	mov rax, SYS_CLOSE
	syscall

	jmp loop

; Unnecessary
exit:
	mov rdi, 0
	mov rax, SYS_EXIT
	syscall

; Syscalls
SYS_WRITE  equ 1
SYS_CLOSE  equ 3
SYS_SOCKET equ 41
SYS_ACCEPT equ 43
SYS_BIND   equ 49
SYS_LISTEN equ 50
SYS_EXIT   equ 60

; Socket params
AF_INET     equ 2
SOCK_STREAM equ 1


; Vars
%define swap_word(x) (x << 8 | x >> 8) & 0xFFFF
sockaddr:
	dw 2
	dw swap_word(8080)
	dd 0
	dd 0
	dd 0
end_sockaddr:
BACKLOG equ 10

%define CRLF 13, 10

message:
	db "HTTP/1.0 200 OK", CRLF, "Connection: Close", CRLF, "Content-Length: 0", CRLF, CRLF
end_message:
