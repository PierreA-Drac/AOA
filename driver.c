#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#define NB_METAS 31

extern uint64_t rdtsc ();

extern void baseline(unsigned n, float a[n][n], double b[n]);

static void init_array_2x (int n, float a[n][n]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            a[i][j] = -1.0 + fmodf((float) rand() / (float) rand(), 2.0);
}

static void init_array_1x (int n, double a[n]) {
    for (int i = 0; i < n; i++)
        a[i] = (double) rand() / RAND_MAX;
}


int main (int argc, char *argv[]) {
    /* Check command line arguments. */
    if (argc != 4)
        return fprintf (stderr, "Usage: %s <size> <nb warmup repets> <nb measure repets>\n", argv[0]), 1;

    int i, m;

    /* Get command line arguments. */
    int size = atoi (argv[1]); /* Matrix size. */
    int repw = atoi (argv[2]); /* Repetition number for warmup. */
    int repm = atoi (argv[3]); /* Repetition number for measures. */

    for (m = 0; m < NB_METAS; m++) {
        /* Allocate arrays. */
        float (*a)[size] = malloc (size * size * sizeof *a[0]);
        double *b        = malloc (size        * sizeof *b);
        
        /* Init arrays. */
        srand(0);
        init_array_2x (size, a);
        init_array_1x (size, b);

        /* Warmup (repw repetitions in first meta, 1 repet in next metas). */
        if (m == 0) {
            for (i = 0; i < repw; i++)
                baseline (size, a, b);
        } else {
            baseline (size, a, b);
        }

        /* Measure repm repetitions. */
        uint64_t t1 = rdtsc();
        for (i = 0; i < repm; i++)
            baseline (size, a, b);
        uint64_t t2 = rdtsc();

        /* Print performance (number of fused-multiply-exponential per cycle). */
        printf ("%.2f\n", (t2 - t1) / ((float) size * size * repm));

        /* Print output. */
        /* if (m == 0) */
            /* print_array (size, a); */

        /* Free arrays. */
        free (a);
        free (b);
    }
    return EXIT_SUCCESS;
}
