#!/usr/bin/env python3
import sys
x = '{:032b}'.format(int(sys.argv[1], 16))
print(' '.join([x[i:i+8] for i in range(0,len(x),8)]))
