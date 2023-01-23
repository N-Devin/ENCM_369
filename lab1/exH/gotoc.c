// lab1exH.c
// ENCM 369 Winter 2023 Lab 1 Exercise H

#include <stdio.h>

void print_array(const char *str, const int *a, int n);
// Prints the string given by str on stdout, then
// prints a[0], a[1], ..., a[n - 1] on stdout on a single line.

void sort_array(int *x, int n);
// Sorts x[0], x[1], ..., x[n - 1] from smallest to largest.

int main(void)
{
  int test_array[] = { 4000, 5000, 7000, 1000, 3000, 4000, 2000, 6000 };

  print_array("before sorting ...", test_array, 8);
  sort_array(test_array, 8);
  print_array("after sorting ...", test_array, 8);
  return 0;
}

void print_array(const char *str, const int *a, int n)
{
    int i = 0;
    puts(str);
    start:
        if (!(i < n)) goto end;
        printf("    %d", a[i]);
        printf("\n");
        i++;
        goto start;
    end:
    ;
};

void sort_array(int *x, int n)
{
  // This is an implementation of an algorithm called insertion sort.

  int outer = 1, inner, vti;
    outer_loop:
        if (!(outer < n)) goto quit_outer_loop;
        vti = x[outer];
        inner = outer;

    inner_loop:
        if (!(inner > 0)) goto quit_inner_loop;
        if (!(vti < x[inner - 1])) goto quit_inner_loop;
        x[inner] = x[inner - 1];
        inner--;
    goto inner_loop;
    quit_inner_loop:
    x[inner] = vti;
    outer++;
    goto outer_loop;
    quit_outer_loop:;
};