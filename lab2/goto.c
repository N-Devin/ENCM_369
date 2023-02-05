#include <stdio.h>

int alpha[8] = { 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1 };
int beta[8] = { 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70 };

int main(void)
{
  int *p;
  int *guard;
  int min, j, k;

  // Put value of smallest element of alpha into min.
  p = alpha;
  guard = p + 8;
  min = *p;
  
  L1:
  p++;
  if (p == guard) goto L3;
    if (*p < min) goto L2;
    goto L1;

    L2:
        min = *p;
        goto L1;

    L3:
  printf("chicken min = %d\n", min);
  j = 0;
  k = 7;

  if (j >= 8) goto L5;
    L4:
        alpha[j] = beta[k];
        j++;
        k--;
        if (j < 8) goto L4;
        L5:
    
  return 0;

}