//****************************************************************************************************************************
//Program name: "240 midterm program". This program takes in user inputted values for Electromagnetic force, Resistance on subcircuit #1, 
// and Resistance on subcircuit #2.
//  It then calculates Current in sub-circuit #1, Current in sub-circuit #2, and Total current in the entire circuit 
// Copyright (C) 2024  Hunter Tran.                           
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Hunter Tran
//Author email: huntertran@csu.fullerton.edu
//Author section: 240-03
//Author CWID: 886474907
//Program name: 240 midterm program
//Programming languages: One module in C, 3 in X86, and one in bash.
//Date program began: 2024-Mar-20
//Date of last update: 2024-Mar-20
//Files in this program: main.c, electricity.asm, current.asm, isfloat.asm, r.sh. 
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in user inputted values for Electromagnetic force, Resistance on subcircuit #1, and Resistance on subcircuit #2.
//  It then calculates Current in sub-circuit #1, Current in sub-circuit #2, and Total current in the entire circuit 

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o main.o -std=c20 -Wall main.c -c
//  Link: g++  -m64 -no-pie -o midterm.out main.o electricity.o isfloat.o current.o -std=c2x -Wall -z noexecstack 


#include <stdio.h>
#include <math.h>
//#include <string.h>
//#include <stdlib.h>

extern double electricity();

int main(int argc, const char *argv[])
{
    printf("Welcome to West Beach Electric Company.\n");
    printf("This software is maintained by Hunter Tran.\n\n");

    double result = electricity();
    
    printf("\nThe main received this number %1.5lf and will keep it for later.", result);
    printf("\nA zero will be returned to the operating system. Bye\n");
}


