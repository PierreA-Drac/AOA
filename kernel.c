#include <math.h>

#ifdef L1_OPT1

/* Make "a" and "b" access stride 1. No speed up and MAQAO detect it to
 * non-stride 1, I don't know why, because it correspond to the example
 * given by MAQAO. To investigate... */

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            if (j == 0)
                b[i] = 1.0;
            b[i] *= exp(a[i][j]);
        }
    }
}

#elif L1_OPT2

/* Remove the if to have only one path. Very little speed-up. */

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (i = 0; i < n; i++)
        b[i] = exp(a[i][0]);
    for (j = 1; j < n; j++)
        for (i = 0; i < n; i++)
            b[i] *= exp(a[i][j]);
}

#elif defined L2_OPT1

#elif defined L3_OPT1

#else

/* Original. */

// a[i][j] between -1 and 1.
void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (j = 0; j < n; j++) {
        for (i = 0; i < n; i++) {
            if (j == 0)
                b[i] = 1.0;
            b[i] *= exp(a[i][j]);
        }
    }
}

#endif
