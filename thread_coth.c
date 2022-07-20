#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

void * pri1();
void * pri2();
float pi = 3.141592;
int i;
float prod1;
float prod2;
float sum = 0, x;

pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;

int main() {
    printf("coth(x). Pick your x\n");
    scanf("%f", &x);

    int n = 100;

    sum += 1.0/x;
    //suma+= (2*x) / (pi*pi*i*i + x*x);

    if(x <= 2.9 && x >= -2.9){
        for(int j = 1; j < n; j++){
            i = j;
            int rc1, rc2;
            pthread_t product1, product2;
            /* creare thread-uri */
            if ((rc1 = pthread_create( & product1, NULL, & pri1, NULL))) {
                printf("thread generating error! %d\n", rc2);
            }
            if ((rc2 = pthread_create( & product2, NULL, & pri2, NULL))) {
                printf("thread generating error! %d\n", rc2);
            }
            pthread_join(product1, NULL);
            pthread_join(product2, NULL);
            //printf("2*x = %f\n(pi*pi*i*i + x*x) = %f\n", prod1, prod2);
    
            sum += prod1/prod2;
            //printf("the final approximation is %f\n", sum);
        }
    }
    else{   
        if(x > 0)
            sum = 1;
        else
            sum = -1;
    }

    printf("the final approximation is %f\n", sum);
    exit(EXIT_SUCCESS);
}

void * pri1() {
    prod1 = 2*x;
    return NULL;
}

void * pri2() {
    prod2 = (pi*pi*i*i + x*x);
    return NULL;
}