_group = {
  {
    group_size = 1,
    pattern = "L",
    opcodes = "CVTSS2SD,",
    offsets = "0,",
    addresses = "0x1586,",
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
    group_size = 1,
    pattern = "L",
    opcodes = "MOV,",
    offsets = "2789,",
    addresses = "0x1574,",
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
  {
    group_size = 1,
    pattern = "S",
    opcodes = "MOV,",
    offsets = "0,",
    addresses = "0x157b,",
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
  {
    group_size = 2,
    pattern = "LS",
    opcodes = "MULSD,MOVSD,",
    offsets = "-8,-8,",
    addresses = "0x1590,0x1599,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 16,
    accessed_memory_nooverlap = 8,
    accessed_memory_overlap = 8,
    span = 8,
    head = 0,
    unroll_factor = 1,
  },
}
