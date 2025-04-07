#include <stdio.h>
#include <stdint.h>

#define WIDTH    128
#define HEIGHT   32
#define SCALE    32
#define MAX_ITER     15

typedef int16_t word;

int main(){
    const word r0 = 0;
    word r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13;

r1 = 1;
r2 = 0;

yloop:
r3 = 0;
    xloop:
        r4 = (2*SCALE);
        r4 = r3 - r4;
        
        r6 = SCALE;
        r5 = r2 << 1;
        r5 = r5 - r6;

        r6 = 0;
        r7 = 0;
        r8 = 0;

        lwhile:
        r9 = r6 * r6;
        r10 = r7 * r7;
        r9 = r9 + r10;

        r10 = (SCALE *  SCALE * 4);
        if(r9 > r10) goto lendwhile;

        r9 = MAX_ITER;
        if(r8 > r9) goto lendwhile;
        ldo:
            r9 = r6* r6;
            r9 = r9 >> 5;

            r10 = r7 * r7;
            r10 = r10 >> 5;
            r9 = r9 - r10;
            r9 = r9 + r4;

            r7 = r6 * r7;
            r7 = r7 >> 4;
            r7 = r7 + r5;

            r6 = r9;
            r8 = r8 + r1;

            goto lwhile;
        lendwhile:
        r10 = MAX_ITER;

        r13 = 0x20;
        if(r8 < r10) goto space;
        r13 = 0x23;
        space:

        putchar(r13);

        r3 = r3 + r1;
        r10 = WIDTH + 1;
    if(r3 < r10) goto xloop;

    r13 = 0x0A;
    putchar(r13);

    r2 = r2 + r1;
    r10 = HEIGHT + 1;

if(r2 < r10) goto yloop;
}