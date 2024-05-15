//****************************************************************************************************************************
//Program name: "Travel Calculator". This program takes in user inputted values of their number of miles traveled and average*
// speed from Fullerton to Santa Ana, Santa Ana to Long Beach, and from Long Beach to Fullerton. It also takes their average *
// speed from city to city. It then calculates the total distance, time, and average speed of their whole trip.              *
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
//Program name: Travel Calculator
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Jan-18
//Date of last update: 2024-Feb-2
//Files in this program: driver.c, average.asm, r.sh. 
//Testing: Alpha testing completed.  All functions are correct.

//Purpose of this program:
//  This program takes in user inputted values of their number of miles traveled and average speed from Fullerton to Santa Ana, 
//  Santa Ana to Long Beach, and from Long Beach to Fullerton. It then calculates the total distance, time, and average speed
//  of their whole trip.

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o driver.o -std=c20 -Wall driver.c -c
//  Link: gcc -m64 -no-pie -o assignment1.out average.o driver.o -std=c20 -Wall -z noexecstack





#include <stdio.h>
//#include <string.h>
//#include <stdlib.h>

extern double compute_average();

int main(int argc, const char * argv[])
{printf("Welcome to Travel Calculator maintained by Hunter Tran\n");
 double result = compute_average();
 printf("\nThe driver has received this number %1.8lf and will keep it for future use.\nHave a great day.\n\n",result);
 printf("A zero will be sent to the operating system as a signal of a successful execution.\n");
}


