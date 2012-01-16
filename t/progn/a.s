        .include "ia-32z.s"
        .text
_f:
        zLIL 3, ax
        zLIL 4, bx
        zADD ax, bx
        HLT
