//****************************************************************************************************************************
//Program name: "Triangle Side Calculator". This program takes in user inputted values of the lengths of two sides of a      *
// triangle and the size of the angle between those two sides. It then calculates The length of the third side. The three    * 
// input values are validated by suitable checking mechanism. Copyright (C) 2024  Hunter Tran.                               *
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
//Program name: Triangle Side Calculator
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Feb-14
//Date of last update: 2024-Feb-23
//Files in this program: driver.c, manager.asm, isfloat.asm, r.sh. 
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in user inputted values of the lengths of two sides of a triangle and the size of the angle between those 
//  two sides. It then calculates The length of the third side. The three input values are validated by suitable checking mechanism.

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o driver.o -std=c20 -Wall driver.c -c
//  Link: gcc -m64 -no-pie -o assignment2.out manager.o driver.o isfloat.o -std=c20 -Wall -z noexecstack





#include <stdio.h>
#include <math.h>
//#include <string.h>
//#include <stdlib.h>

extern double compute_triangle();

int main(int argc, const char * argv[]) {
    printf("Welcome to Amazing Triangles programmed by Hunter Tran on February 14, 2024.\n\n");

    double result = compute_triangle();

    printf("\nThe driver received this number %1.10lf and will simply keep it.\n\n",result); 

    printf("An integer zero will now be sent to the operating system.   Bye\n");
}


