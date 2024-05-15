//****************************************************************************************************************************
//Program name: "Triangle Area Calculator". This program takes in user inputted values of the lengths of two sides of a      * 
// triangle and the degrees of the angle between those two sides. It then computes the area of a triangle.                   *
// Copyright (C) 2024  Hunter Tran.                                                                                          *
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
//Program name: Triangle Area Calculator
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Apr-25
//Date of last update: 2024-May-11
//Files in this program: director.c, producer.asm, sin.asm, r.sh.  
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in user inputted values of the lengths of two sides of a triangle and the degrees of the angle between those 
//  two sides. It then computes the area of a triangle.

//This file
//  File name: director.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o director.o -std=c20 -Wall director.c -c
//  Link: g++  -m64 -no-pie -o assignment5.out director.o producer.o sin.o -std=c2x -Wall -z noexecstack 


#include <stdio.h>
#include <math.h>
//#include <string.h>
//#include <stdlib.h>

extern double producer();

int main(int argc, const char *argv[])
{
    printf("Welcome to Marvelous Hunter’s Area Machine.\n");
    printf("We compute all your areas.\n\n");

    double result = producer();
    
    printf("\n\nThe driver received this number %1.5lf and will keep it.", result);
    printf("\nA zero will be sent to the OS as a sign of successful conclusion.\n");
    printf("Bye\n");
}