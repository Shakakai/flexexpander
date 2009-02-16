#!/usr/bin/env python
# encoding: utf-8


"""

Flex object Classes for Flex Expander
copyright Todd Cullen

"""

class FlexFacade(object):
    
    def __init__(self):
        self.interfaces = []
        self.commands = []
        self.mediators = []
        self.proxies = []
    

class FlexObject(object):
    
    def __init__(self):
        self.name = ""
        self.lazy = False
        self.isSingleton = True
        self.interface = []
        self.properties = []
        self.args = []
        self.factoryMethod = None
        self.clazz = ""
        self.isFrameworkClazz = False
    

class FlexProperty(object):
    
    def __init__(self):
        self.name = ""
        self.value = ""
        self.isRef = False
    
class FlexInterface(object):
    
    def __init__(self):
        self.name = ""
        self.methods = []
    

class FlexMethod(object):
    
    def __init__(self):
        self.name = ""
        self.returnType = ""
        self.arguments = []
    

class FlexArgument(object):
    
    def __init__(self):
        self.name = ""
        self.type = ""
    

class FlexFrameworkItem(object):
    
    def __init__(self):
        self.name = ""
        self.ref = ""

