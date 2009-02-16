#!/usr/bin/env python
# encoding: utf-8


"""

Flex object Classes for Flex Expander
copyright Todd Cullen

"""

import urllib
from xml.dom import minidom
from django.template.loader import render_to_string
from django.conf import settings

from flex_objects import *
from flex_expander_utils import *


OUTPUT_DIR = "generated/"
FLEX_EXPANDER_NS = "http://www.shakakai.com/xmlns/flex/expander"



class FlexExpander(object):
    
    def __init__(self,descriptor, source, package):
        self.properties = []
        self.objects = []
        self.facade = FlexFacade();
        self.url = descriptor
        self.rootDir = "/".join(descriptor.split("/")[1:-1]) + "/"
        if(self.rootDir[0] != '/'):
            self.rootDir = "/"+self.rootDir
        self.sourceDir = source
        self.generatedDir = self.sourceDir + "/" + package.replace(".", "/") + "/generated/"
        self.templateDir = get_path() + "/templates"
        self.basePacakge = package
        self.flexImports = []
        settings.configure(DEBUG=True, TEMPLATE_DEBUG=True, TEMPLATE_DIRS=(self.templateDir,self.templateDir))
        
    
    @classmethod
    def expand(cls, descriptor, source, package):
        c = cls(descriptor,source,package)
        c.parse()
        return c
    
    def parse(self):
        self.dom = minidom.parse(self.url)
        self.loadProperties()
        self.addIncludes()
        self.processObjects()
        self.processFacade()
        
        prepareDir(self.generatedDir)
        prepareDir(self.generatedDir + "interfaces/")
        self.output()
    
    def getEl(self,el):
        return self.dom.getElementsByTagNameNS(FLEX_EXPANDER_NS,el);
    
    def getRelFile(self,doc):
        f = open(self.rootDir+doc)
        return f.read();
    
    def writeRelFile(self,doc,output):
        f = open(doc, "w+")
        f.write(output)
    
    def addImport(self, imp):
        for item in self.flexImports:
            if(imp == item):
                return
            
        self.flexImports.append(imp)
    
    def loadProperties(self):
        for prop in self.getEl("properties"):
            src = prop.getAttribute("src")
            for line in self.getRelFile(src).split("\n"):
                pair = line.split("=")
                item = {'name' : pair[0], 'value' : "=".join(pair[1:-1])}
                self.properties.append(item)
            prop.parentNode.removeChild(prop)
    
    def addIncludes(self):
        for inc in self.getEl("include"):
            txt = self.getRelFile(inc.getAttribute("src"))
            subdom = minidom.parseString(txt)
            for item in subdom.childNodes:
                subdom.removeChild(item)
                inc.parentNode.appendChild(item)
            inc.parentNode.removeChild(inc)
    
    def processObjects(self):
        for obj in self.getEl("object"):
            no = FlexObject()
            no.name = obj.getAttribute("id")
            no.clazz = obj.getAttribute("class")
            
            self.addImport(no.clazz)
            
            interfaces = obj.getAttribute("interfaces")
            if(interfaces != ''):
                no.interfaces = interfaces.split(",")
            
            scope = obj.getAttribute("scope")
            if(scope != ''):
                no.isSingleton = (scope == 'singleton')
            
            lazyInit = obj.getAttribute("lazyInit")
            if(lazyInit != ''):
                no.lazy = (lazyInit == 'true')
            
            for prop in obj.getElementsByTagNameNS(FLEX_EXPANDER_NS,"property"):
                fp = FlexProperty()
                fp.name = prop.getAttribute("name")
                ref = prop.getAttribute("ref")
                if( ref != ''):
                    fp.value = ref
                    fp.isRef = True
                else:
                    fp.value = prop.getAttribute("value")
                    for p in self.properties:
                        fp.value = fp.value.replace("${"+p['name']+"}", p['value'])
                no.properties.append(fp)
            self.objects.append(no)
        
    
    def findObjectByName(self, name):
        for obj in self.objects:
            if(obj.name == name):
                return obj
            
        return None
    
    def processFacade(self):
        fac = self.getEl("facade")[0]
        
        for interface in fac.getElementsByTagNameNS(FLEX_EXPANDER_NS, "interface"):
            fxInter = FlexInterface()
            fxInter.name = interface.getAttribute('name')
            for meth in interface.getElementsByTagNameNS(FLEX_EXPANDER_NS, "method"):
                fxMeth = FlexMethod()
                fxMeth.name = meth.getAttribute("name")
                rtn = meth.getAttribute("returnType")
                if( rtn != '' ):
                    fxMeth.returnType = rtn
                    if(rtn.count(".")>0):
                        self.addImport(rtn)
                else:
                    fxMeth.returnType = 'void'
                for arg in meth.getElementsByTagNameNS(FLEX_EXPANDER_NS, "argument"):
                    fxArg = FlexArgument()
                    fxArg.name = arg.getAttribute("name")
                    fxArg.type = arg.getAttribute("type")
                    if(fxArg.type.count(".")>0):
                        self.addImport(fxArg.type)
                    fxMeth.arguments.append(fxArg)
                fxInter.methods.append(fxMeth)
            self.facade.interfaces.append(fxInter)
            
        
        for fType in [['mediator','mediators'],['proxy','proxies'],['command','commands']]:
            for item in fac.getElementsByTagNameNS(FLEX_EXPANDER_NS, fType[0]):
                i = FlexFrameworkItem()
                i.name = item.getAttribute("name")
                i.ref = item.getAttribute("ref")
                obj = self.findObjectByName(i.ref)
                if(obj == None):
                    log("Could not find object with name: " + i.ref)
                obj.isFrameworkClazz = True
                getattr(self.facade, fType[1]).append(i)
            
        

    def output(self):
        generatedPkg = self.basePacakge + ".generated"
        
        # expand imports to include new interfaces & core framework
        self.addImport(generatedPkg+".*")
        self.addImport(generatedPkg+".interfaces.*")
        
        # application interfaces
        for interface in self.facade.interfaces:
            self.out("interface.pyas", "interfaces/"+interface.name+".as", {'interface' : interface, 'package' : generatedPkg + ".interfaces", 'imports' : self.flexImports})
        
        # framework core
        self.out("facade.pyas", "Facade.as", {'interfaces' : self.facade.interfaces, 'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("container.pyas", "Container.as", {'objects' : self.objects, 'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("view.pyas", "View.as", {'mediators' : self.facade.mediators, 'interfaces' : self.facade.interfaces, 'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("proxy.pyas", "Proxy.as", {'proxies' : self.facade.proxies, 'interfaces' : self.facade.interfaces, 'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("controller.pyas", "Controller.as", {'commands' : self.facade.commands, 'interfaces' : self.facade.interfaces, 'package' : generatedPkg, 'imports' : self.flexImports})
        
        # application base classes
        self.out("proxy_base.pyas", "BaseProxy.as", {'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("mediator_base.pyas", "BaseMediator.as", {'package' : generatedPkg, 'imports' : self.flexImports})
        self.out("command_base.pyas", "BaseCommand.as", {'package' : generatedPkg, 'imports' : self.flexImports})
        
        self.out("command_interface.pyas", "interfaces/ICommand.as", {'package' : generatedPkg + ".interfaces", 'imports' : self.flexImports})
        self.out("proxy_interface.pyas", "interfaces/IProxy.as", {'package' : generatedPkg + ".interfaces", 'imports' : self.flexImports})
        self.out("mediator_interface.pyas", "interfaces/IMediator.as", {'package' : generatedPkg + ".interfaces", 'imports' : self.flexImports})
        
        
    def out(self, template, file, data):        
        fOut = render_to_string(template, data)
        self.writeRelFile(self.generatedDir+file, fOut)  
