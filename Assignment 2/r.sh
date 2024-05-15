#/bin/bash

#Program name "Triangle Side Calculator"
#Author: Hunter Tran
#Author section: 240-03
#Author CWID: 886474907
#Author email: huntertran@csu.fullerton.edu
#This file is the script file that accompanies the "Triangle Side Calculator" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

nasm -f elf64 -l manager.lis -o manager.o manager.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

gcc -m64 -no-pie -o assignment2.out driver.o manager.o isfloat.o -std=c2x -Wall -z noexecstack -lm

chmod +x assignment2.out
./assignment2.out

