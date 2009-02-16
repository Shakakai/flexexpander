#!/usr/bin/env python
# encoding: utf-8


"""

Flex object Classes for Flex Expander
copyright Todd Cullen

"""

import sys
import os

def log(msg):
    print msg


def get_path():
    return sys.path[0]

def prepareDir(loc):
    d = os.path.dirname(loc)
    if not os.path.exists(d):
        os.makedirs(d)
