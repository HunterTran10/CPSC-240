#/bin/bash

#Program name "240 midterm program"
#Author: Hunter Tran
#Author section: 240-03
#Author CWID: 886474907
#Author email: huntertran@csu.fullerton.edu
#Today’s date: Mar 20, 2024
#This file is the script file that accompanies the "240 midterm program" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l electricity.lis -o electricity.o electricity.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

nasm -f elf64 -l current.lis -o current.o current.asm

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

g++  -m64 -no-pie -o midterm.out main.o electricity.o isfloat.o current.o -std=c2x -Wall -z noexecstack 

chmod +x midterm.out
./midterm.out

