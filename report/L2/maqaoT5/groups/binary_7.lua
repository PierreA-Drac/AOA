_group = {
  {
    group_size = 8,
    pattern = "LLLLLLLL",
    opcodes = "CVTSS2SD,CVTSS2SD,CVTSS2SD,CVTSS2SD,CVTSS2SD,CVTSS2SD,CVTSS2SD,CVTSS2SD,",
    offsets = "-32,-28,-24,-20,-16,-12,-8,-4,",
    addresses = "0x15b0,0x15ca,0x15e4,0x15fe,0x1618,0x1632,0x164c,0x1666,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 32,
    accessed_memory_nooverlap = 32,
    accessed_memory_overlap = 0,
    span = 32,
    head = 0,
    unroll_factor = 8,
  },
  {
    group_size = 16,
    pattern = "LSLSLSLSLSLSLSLS",
    opcodes = "MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,MULSD,MOVSD,",
    offsets = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",
    addresses = "0x15ba,0x15c0,0x15d4,0x15da,0x15ee,0x15f4,0x1608,0x160e,0x1622,0x1628,0x163c,0x1642,0x1656,0x165c,0x1670,0x1679,",
    stride_status = "Not mono block loop",
    stride = 0,
    memory_status = "Success",
    accessed_memory = 128,
    accessed_memory_nooverlap = 8,
    accessed_memory_overlap = 120,
    span = 8,
    head = 0,
    unroll_factor = 1,
  },
}