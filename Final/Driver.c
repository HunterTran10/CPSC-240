// Author name: Hunter Tran
// Author email: huntertran@csu.fullerton.edu
// Course and section: CPSC240-3
// Today’s date: May 13, 2024


#include <stdio.h>
#include <math.h>
//#include <string.h>
//#include <stdlib.h>

extern double Dot();

int main(int argc, const char *argv[])
{
    printf("Welcome to the CS 240-3 final exam\n");
    printf("This program is maintained by Hunter Tran.\n\n");

    double result = Dot();
    
    printf("\nThe driver receive %1.1lf and will keep it.", result);
    printf("\nA  0 will be sent to the OS.  Bye\n");
}