
#include <stdio.h>
#include <unistd.h>

///extern "C"{
#include <iostream>
#include <string>

int main(void){

    int i;

    sleep(2);
    printf("hello in c...\n");

    std::cout << "hello in cpp !!! \n" << std::endl;

    return 0;
}



//} // end extern "C"
