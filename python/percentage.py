#!/usr/bin/env  python

from __future__ import division
import sys

def percentage(Numerator, Denominator):
    print "{0:.2f}%".format(Numerator * 100.0 / Denominator)


if __name__ == '__main__':
    den = 0.0 
    for num in sys.argv[1:]:
        den += int(num)
    
    for num in sys.argv[1:]:
        percentage(int(num), den)
