#/bin/bash

#Program name "Array Calculator"
#Author: Hunter Tran
#Author section: 240-03
#Author CWID: 886474907
#Author email: huntertran@csu.fullerton.edu
#This file is the script file that accompanies the "Array Calculator" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l manager.lis -o manager.o manager.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm

gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c

g++  -m64 -Wall -fno-pie -no-pie -o compute_variance.o -std=c++17 -c compute_variance.cpp

gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c

g++  -m64 -no-pie -o assignment3.out main.o manager.o isfloat.o input_array.o output_array.o compute_mean.o compute_variance.o -std=c2x -Wall -z noexecstack 

chmod +x assignment3.out
./assignment3.out

