nasm -f elf64 coth.asm
gcc -m64 -no-pie -o coth coth.o
coth
