#/bin/bash

#Program name "Triangle Area Calculator"
#Author: Hunter Tran
#Author section: 240-03
#Author CWID: 886474907
#Author email: huntertran@csu.fullerton.edu
#This file is the script file that accompanies the "Triangle Area Calculator" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Compile the source file director.c"
gcc  -m64 -Wall -no-pie -o director.o -std=c2x -c director.c

echo "Assemble the source file producer.asm"
nasm -f elf64 -l producer.lis -o producer.o producer.asm

echo "Assemble the source file sin.asm"
nasm -f elf64 -l sin.lis -o sin.o sin.asm

echo "Link the object modules to create an executable file"
g++  -m64 -no-pie -o assignment5.out director.o producer.o sin.o -std=c2x -Wall -z noexecstack

echo "Execute the Assignment 5 program"
chmod +x assignment5.out
./assignment5.out

echo "This bash script will now terminate."