#include <math.h>

#ifdef L1_OPT1

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
