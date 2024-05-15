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
//  File name: sort.cpp
//  Language: C++ language
//  Compile: g++  -m64 -Wall -fno-pie -no-pie -o sort.o -std=c++17 -c sort.cpp
//  Link: g++  -m64 -no-pie -o assignment4.out main.o executive.o fill_random_array.o normalize_array.o show_array.o isnan.o sort.o -std=c2x -Wall -z noexecstack 

#include <stdio.h>
#include <math.h>

extern "C" void sort(double array[], int array_size);

void sort(double array[], int array_size) {
    
    double tmp;

    for (int i = 0; i < array_size - 1; i++) {
        for (int j = 0; j < array_size - 1; j++) {
            if (array[j] > array[j + 1]) {
                
                tmp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = tmp;
            }
        }
    }
}

