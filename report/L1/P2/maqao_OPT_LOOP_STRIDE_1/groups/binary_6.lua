_group = {
  {
    group_size = 1,
    pattern = "L",
    opcodes = "CVTSS2SD,",
    offsets = "0,",
    addresses = "0x151f,",
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
    group_size = 3,
    pattern = "SLS",
    opcodes = "MOV,MULSD,MOVSD,",
    offsets = "0,0,0,",
    addresses = "0x1517,0x152a,0x1533,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 24,
    accessed_memory_nooverlap = 8,
    accessed_memory_overlap = 16,
    span = 8,
    head = 0,
    unroll_factor = 1,
  },
  {
    group_size = 1,
    pattern = "L",
    opcodes = "MOV,",
    offsets = "2889,",
    addresses = "0x1510,",
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