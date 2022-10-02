.386 ; 
.model flat, stdcall ;
option casemap:none ;

include c:\masm32\include\windows.inc ; в этом файле хранится константа NULL
include c:\masm32\include\kernel32.inc ; в этом файле (объявление) прототип функции ExitProcess
include c:\masm32\include\user32.inc ; в этом файле (объявление) прототип функции wsprintf
include c:\masm32\include\masm32.inc ; в этом файле (объявление) прототип функции atol

includelib c:\masm32\lib\kernel32.lib ; в этом файле машинный код функции ExitProcess
includelib c:\masm32\lib\user32.lib ; в этом файле машинный код функции wsprintf
includelib c:\masm32\lib\masm32.lib ; в этом файле машинный код функции atol

.const
BSIZE equ 100 ; 

.data ; 
linefmt db 0ah, 0dh, "Please, set the mark for my work!", 0
linefmt_1 db 0ah, 0dh, "Determinant = %d", 0
linename db "Klimov Aleksandr Evgen'evich", 0
linegroup db 0ah, 0dh, "Group I-AMI-II", 0
linevar db 0ah, 0dh, "Variant 8", 0ah , 0dh, 0
p_1 dd 5
p_2 dd -1
l_1 dd 4
l_2 dd 0
sum1 dd 0
sum2 dd 0
sum dd 0
format db 0ah, 0dh, '%d ','%d',0
format_1 db 0ah, 0dh, '%d ','%d',0
format_2 db 0ah, 0dh, '%d ',0
msg_1 db 0ah, 0dh, "Array:",0

.data? ;
buf dw BSIZE dup(?)
buf_1 dw BSIZE dup(?)
stdout dd ? ; 
cWritten dd ? ; 
stdin dd ?
cRead dd ?
val_1 word ?

.code ;
start:

invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr linename, sizeof linename, addr cWritten, NULL ;

invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr linegroup, sizeof linegroup, addr cWritten, NULL ;

invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr linevar, sizeof linevar, addr cWritten, NULL ;

invoke AllocConsole
xor eax,eax
invoke GetStdHandle, STD_OUTPUT_HANDLE ;
mov stdout, eax ;
invoke wsprintf, addr buf, addr msg_1
invoke WriteConsole, stdout, addr buf, sizeof buf, addr cWritten, NULL

mov eax, p_1
mul l_2

mov sum1, eax

mov eax, p_2
mul l_1

mov sum2,eax

mov eax,sum1
sub eax,sum2

mov sum,eax

invoke wsprintf, addr buf_1,addr format, p_1,p_2
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr buf_1, sizeof buf_1, addr cWritten, NULL ;

invoke wsprintf, addr buf_1,addr format_1, l_1,l_2
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr buf_1, sizeof buf_1, addr cWritten, NULL ;

invoke wsprintf, addr buf_1,addr linefmt_1, sum
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov stdout, eax
invoke WriteConsole, stdout, addr buf_1, sizeof buf_1, addr cWritten, NULL ;

invoke GetStdHandle, STD_OUTPUT_HANDLE ; 
mov stdout, eax ;
invoke wsprintf, addr buf, addr linefmt
invoke WriteConsole, stdout, addr buf, sizeof buf, addr cWritten, NULL ; 

invoke GetStdHandle, STD_INPUT_HANDLE

mov stdin, eax

invoke ReadConsole, stdin, ADDR buf, BSIZE, ADDR cRead, NULL ;

invoke Sleep, INFINITE
invoke ExitProcess, 0
end start
