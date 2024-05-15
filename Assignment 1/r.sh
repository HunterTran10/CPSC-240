#/bin/bash

#Program name "Travel Calculator"
#Author: Hunter Tran
#Author section: 240-03
#Author CWID: 886474907
#Author email: huntertran@csu.fullerton.edu
#This file is the script file that accompanies the "Travel Calculator" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l average.lis -o average.o average.asm

gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

gcc -m64 -no-pie -o assignment1.out driver.o average.o -std=c2x -Wall -z noexecstack

chmod +x assignment1.out
./assignment1.out

