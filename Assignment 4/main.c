//****************************************************************************************************************************
//Program name: "Random Array Sorter". This program takes in a user inputted array size and fills the array with             *
//  random numbers. It then normalizes it to the range 1.0 to 2.0 and sorts it in ascending order.                           *
//  Copyright (C) 2024  Hunter Tran.                                                                                         *
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
//Program name: Random Array Sorter
//Programming languages: One module in C, five in X86, one in C++, and one in bash.
//Date program began: 2024-Mar-27
//Date of last update: 2024-Apr-12
//Files in this program: main.c, executive.asm, fill_random_array.asm, normalize_array.asm, show_array.asm, sort.cpp, isnan.asm, r.sh. 
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in a user inputted array size and fills the array with random numbers. It then normalizes it to the range
//  1.0 to 2.0 and sorts it in ascending order.

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o main.o -std=c20 -Wall main.c -c
//  Link: g++  -m64 -no-pie -o assignment4.out main.o executive.o fill_random_array.o normalize_array.o show_array.o isnan.o sort.o -std=c2x -Wall -z noexecstack 


#include <stdio.h>
#include <math.h>
//#include <string.h>
//#include <stdlib.h>

extern char* executive();

int main(int argc, const char *argv[])
{
    printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Hunter Tran\n");

    char* result = executive();
    
    printf("\nOh, %s.  We hope you enjoyed your arrays.  Do come again.", result);
    printf("\nA zero will be returned to the operating system.\n");
}


