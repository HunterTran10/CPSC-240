#/bin/bash

# Author name: Hunter Tran
# Author email: huntertran@csu.fullerton.edu
# Course and section: CPSC240-3
# Today’s date: May 13, 2024


#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l Dot.lis -o Dot.o Dot.asm

nasm -f elf64 -l Input_dot.lis -o Input_dot.o Input_dot.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

gcc  -m64 -Wall -no-pie -o Driver.o -std=c2x -c Driver.c

g++  -m64 -no-pie -o finalexam.out Driver.o Dot.o Input_dot.o isfloat.o -std=c2x -Wall -z noexecstack 

chmod +x finalexam.out
./finalexam.out