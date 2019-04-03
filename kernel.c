#include <math.h>

// a[i][j] between -1 and 1.

#ifdef OPT_LOOP_STRIDE_1

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
    int tail = (n%2 == 1);
    for (j = 0; j < n; j++) {
        for (i = 0; i < n-1; i+=2) {
            if (j == 0) {
                b[i] = 1.0;
                b[i+1] = 1.0;
            }
            b[i] *= exp(a[i][j]);
            b[i+1] *= exp(a[i+1][j]);
        }
        if (tail) {
            if (j == 0)
                b[n-1] = 1.0;
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

#elif OPT_EXP1

/* Use math.h float version of exponential, instead of double version. Very fast
 * version instead of double exp(). */

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (j = 0; j < n; j++) {
        for (i = 0; i < n; i++) {
            if (j == 0)
                b[i] = 1.0;
            b[i] *= expf(a[i][j]);
        }
    }
}

#elif OPT_EXP2

/* Optimized version of exponential function. Accurate for small x (< 5), and
 * give a high speed-up used instead of exp() ! We can use this version with no
 * accuracy problem because we know that value of a[i][j] are between -1 and 1.
 * This version is base on limit expression of exponential function. The
 * speed-up is small if we use expf(). Can be more optimized with SSE, like in
 * Agner Fog manual. For a next optimization... */

inline static float exp_opt(float x) {
  x = 1.0 + (x / 256.0);
  x *= x; x *= x; x *= x; x *= x;
  x *= x; x *= x; x *= x; x *= x;
  return x;
}

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (j = 0; j < n; j++) {
        for (i = 0; i < n; i++) {
            if (j == 0)
                b[i] = 1.0;
            b[i] *= exp_opt(a[i][j]);
        }
    }
}

#elif OPT_OMP

/* Parallelize the loop with OpenMP library to use all threads. Negative
 * speed-up with small data set (L1) due to a lot more control and
 * synchronizations between threads, but can give a high speed-up for large data
 * set (L2, L3, RAM). */

#include <omp.h>

void baseline(unsigned n, float a[n][n], double b[n])
{
    unsigned i, j;
    for (j = 0; j < n; j++) {
        #pragma omp parallel for
            for (i = 0; i < n; i++) {
                if (j == 0)
                    b[i] = 1.0;
                b[i] *= exp(a[i][j]);
            }
    }
}

#elif OPT_BEST_L1

/* TODO Can we use float instead of double ? It's reduce memory footprint, and also
 * calculation time, because for now we mixing float and double in one
 * computation, which is really bad for performance. */

inline static float exp_opt(float x) {
  x = 1.0 + (x / 256.0);
  x *= x; x *= x; x *= x; x *= x;
  x *= x; x *= x; x *= x; x *= x;
  return x;
}

void baseline(unsigned n, float (* restrict a)[n], double * restrict b)
{
    unsigned i, j;
    for (i = 0; i < n; i++)
        b[i] = exp_opt(a[i][0]);
    int tail = (n%2 == 1);
    for (i = 0; i < n; i++) {
        for (j = 1; j < n-1; j+=2) {
            b[i] *= exp_opt(a[i][j]);
            b[i] *= exp_opt(a[i][j+1]);
        }
        if (tail)
            b[i] *= exp_opt(a[i][n-1]);
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
