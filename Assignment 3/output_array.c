//****************************************************************************************************************************
//Program name: "Array Calculator". This program takes in user inputted values and puts them into an array. It then          *
//  calculates the mean and variance of the numbers in the array. Copyright (C) 2024  Hunter Tran.                           *
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
//Program name: Array Calculator
//Programming languages: Two modules in C, four in X86, one in C++, and one in bash.
//Date program began: 2024-Mar-1
//Date of last update: 2024-Mar-15
//Files in this program: main.c, manager.asm, input_array.asm, output_array.c, compute_mean.asm, compute_variance.cpp, isfloat.asm, r.sh. 
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in user inputted values and puts them into an array. It then calculates the mean and variance of the numbers 
//  in the array.

//This file
//  File name: output_array.c
//  Language: C language
//  Compile: gcc -m64 -no-pie -o output_array.o -std=c20 -Wall output_array.c -c
//  Link: g++ -m64 -no-pie -o assignment3.out main.o manager.o isfloat.o input_array.o output_array.o compute_mean.o compute_variance.o -std=c20 -Wall -z noexecstack

#include <stdio.h>
#include <math.h>

extern void output_array(double array[], int array_index);

void output_array(double array[], int array_index)
{
    int i;

    for (i = 0; i < array_index; i++) {
        printf("%1.8lf   ", array[i]);
        // prints out all the numbers in the array with 8 digits to the right of the point
    }
    
    printf("\n");
}
