#include <math.h>

// a[i][j] between -1 and 1.

#ifdef OPT_STRIDE_1

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

#elif OPT_IF_HOISTING

/* Remove the if to have only one path : very little speed-up. */

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (i = 0; i < n; i++)
        b[i] = exp(a[i][0]);
    for (j = 1; j < n; j++)
        for (i = 0; i < n; i++)
            b[i] *= exp(a[i][j]);
}

#elif OPT_LOOP_UNROLLING

/* Unroll the inner loop : little speed-up. Unrolling the outer loop imply a
 * performance downgrade. */

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (j = 0; j < n; j++) {
        for (i = 0; i < n-1; i+=2) {
            if (j == 0) {
                b[i] = 1.0;
                b[i+1] = 1.0;
            }
            b[i] *= exp(a[i][j]);
            b[i+1] *= exp(a[i+1][j]);
        }
    }
    if (n%2 == 1) {
        for (j = 0; j < n; j++) {
            if (j == 0) {
                b[n-1] = 1.0;
            }
            b[n-1] *= exp(a[n-1][j]);
        }
    }
}

#elif OPT_RESTRICT

/* Use restrict keywork to indicate to the compiler that arrays are independant
 * and do not overlap each other. This could cause better vectorization or code
 * re-arrangement. */

void baseline(unsigned n, float (* restrict a)[n], double * restrict b)
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

#elif defined L2_OPT1

#elif defined L3_OPT1

#else

/* Original. */

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
