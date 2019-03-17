_cqa_text_report = {
  paths = {
  },
  common = {
    header = {
      "",
      "This function cannot be analyzed: too many paths (160 paths > max_paths=4). Rerun with -max_paths=160.\n",
      "This function contains loops. If profiling identifies them as cold, consider removing them by full-unrolling. Otherwise analyze/optimize them.\n",
    },
  },
}
