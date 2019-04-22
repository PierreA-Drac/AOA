_group = {
  {
    group_size = 1,
    pattern = "S",
    opcodes = "MOVSS,",
    offsets = "-4,",
    addresses = "0x1271,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 4,
    accessed_memory_nooverlap = 4,
    accessed_memory_overlap = 0,
    span = 4,
    head = 0,
    unroll_factor = 1,
  },
  {
    group_size = 2,
    pattern = "LL",
    opcodes = "MULSS,SUBSS,",
    offsets = "3559,3555,",
    addresses = "0x1261,0x1269,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 8,
    accessed_memory_nooverlap = 8,
    accessed_memory_overlap = 0,
    span = 8,
    head = 0,
    unroll_factor = 1,
  },
}