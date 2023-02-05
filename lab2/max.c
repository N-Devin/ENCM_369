#include <stdio.h>
int main() {

    int abc[ ] = {-32, -8, -4, -16, -128, -64};
    int max = abc[0];
    int p = 0;

    start:
    if (p == 6) goto end;
    if (abc[p] > max) goto update;
    p = p + 1;
    goto start;

    update:
    max = abc[p];
    p = p + 1;
    goto start;
    end:

    printf("Max = %d)", max);
   return 0;
}