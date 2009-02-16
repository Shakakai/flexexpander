#!/usr/bin/env python
# encoding: utf-8
"""
flex_expander.py

Created by  on 2009-01-31.
Copyright (c) 2009 Todd Cullen. All rights reserved.
"""

import os
import sys
import getopt
from flex_expander_core import *

help_message = '''
The help message goes here.
'''

class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg


def main(argv=None):
    if argv is None:
        argv = sys.argv
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "ho:vd:s:p:", ["help", "output="])
        except getopt.error, msg:
            raise Usage(msg)
    
        # option processing
        log(argv)
        for option, value in opts:
            log(option)
            if option == "-v":
                verbose = True
            if option in ("-h", "--help"):
                raise Usage(help_message)
            if option in ("-o", "--output"):
                output = value
            if option in ("-d", "--descriptor"):
                descriptor = value
            if option in ("-s", "--source"):
                source = value
            if option in ("-p", "--package"):
                package = value
        
        log(descriptor + ":" + source + ":" + package)
        FlexExpander.expand(descriptor, source, package)
        
    except Usage, err:
        print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
        print >> sys.stderr, "\t for help use --help"
        return 2


if __name__ == "__main__":
    sys.exit(main())
