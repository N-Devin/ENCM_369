# include<stdio.h>
int procC(int x)
{
    // POINT ONE

    return 8 * x + 2 * x;
}

void procB(int *p, int *q)
{

BEG:
    if (p == q) goto END;
            *p = procC(*p);
        p++;
    goto BEG;
END:;
    
}

int procA(int s, int *a, int n)
{
    int k;
    k = n - 1;
    procB(a, a + n);
BEG:
    if (k < 0) goto POINT_TWO;
    s += a[k];
    k--;
    printf("%d\n",s);
    goto BEG;
POINT_TWO:
    

    return s;
}

int gg[] = { 2, 3, 4 };

int main(void)
{
    int mv;
    mv = 1000;
    mv += procA(200, gg, 3);
    printf("%d\nd",mv);
    return 0;
}
