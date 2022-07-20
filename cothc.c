#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(){
    float x;
    float sum = 0;
    float pi = 3.141592;

    printf("coth(x). Pick x\n");
    scanf("%f", &x);
    int n = 100;

    if(x <= 2.9 && x >= -2.9){
        sum = 1/x;
        for(int i = 1; i < n; i++)
            sum += (2*x) / (pi*pi*i*i + x*x); 
    }
    else{   
        if(x > 0)
            sum = 1;
        else
            sum = -1;
    }

    printf("the coth function approximation:%f\n", sum);
    return 0;
}