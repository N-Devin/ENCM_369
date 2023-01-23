// lab1exG.c
// ENCM 369 Winter 2023 Lab 1 Exercise G

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ABS_F (5.0e-9)
#define POLY_DEGREE 4

double polyval(const double *a, int n, double x);
/* Return a[0] + a[1] * x + ... + a[n] * pow(x, n). */

int main(void)
{
    double f[] = {1.47, 0.73, -2.97, -1.15, 1.00};
    double dfdx[POLY_DEGREE];

    double guess;
    int max_updates;
    int update_count;
    int n_scanned;
    int i;

    double current_x, current_f, current_dfdx;

    printf("This program demonstrates use of Newton's Method to find\n"
           "approximate roots of the polynomial\nf(x) = ");
    printf("%.2f", f[0]);


    i = 1;
    loop_top_1:
    if (!(i <= POLY_DEGREE)) goto past_end_0;

        if (f[i] >= 0) goto else_code_1;
        printf(" - %.2f*pow(x,%d)", -f[i], i);
        goto end_if_1;
        else_code_1:
            printf(" + %.2f*pow(x,%d)", f[i], i);
            end_if_1:
    i++;
    goto loop_top_1;
    past_end_0:

    printf("\nPlease enter a guess at a root, and a maximum number of\n"
           "updates to do, separated by a space.\n");
    n_scanned = scanf("%lf%d", &guess, &max_updates);

    if (!(n_scanned != 2)) goto end_1;
    printf("Sorry, I couldn't understand the input.\n");
    exit(1);
    end_1:
    ;

    if (!(max_updates < 1)) goto end_2;
    printf("Sorry, I must be allowed do at least one update.\n");
    exit(1);
    end_2:
    ;
    printf("Running with initial guess %f.\n", guess);




    for (i = POLY_DEGREE - 1; i >= 0; i--)
        dfdx[i] = (i + 1) * f[i + 1];   // Calculus!

    current_x = guess;
    update_count = 0;

    int k = 1;
    loop_top_in:
    if (k == 0) goto past_end_1;
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
               update_count, current_x, current_f);

        if (fabs(current_f) < MAX_ABS_F)
            goto past_end_1;
        if (update_count == max_updates)
            goto past_end_1;

        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;
        goto loop_top_in;
    past_end_1:

    if (fabs(current_f) >= MAX_ABS_F) goto else_code_2;
        printf("Stopped with approximate solution of %.10f.\n", 
               current_x);
    goto end_if_5;
    
    else_code_2:
    printf("%d updates performed, |f(x)| still >= %g.\n", 
            update_count, MAX_ABS_F);
    end_if_5:
    return 0;
}



double polyval(const double *a, int n, double x)
{
    double result = a[n];
    int i;
    i = n - 1;
    loop_top_2:
    if (!(i >= 0)) goto past_end_2;
    result *= x;
    result += a[i];
    i--;
    goto loop_top_2;
    past_end_2:
    return result;
}

