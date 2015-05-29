//
//  FileURL.swift
//  Background testing
//
//  Created by Hassam Solano on 4/3/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class FileURL: NSFileManager{
    
    private var rootURL:NSURL!
    private var fileManager:NSFileManager!
    private var infolderArray:NSMutableArray!
    private var rtnURL:NSURL!
    
    override init () {
        
        fileManager = NSFileManager.defaultManager()
        
        rootURL = fileManager.URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        rootURL = rootURL.URLByAppendingPathComponent("/")
        
        infolderArray = NSMutableArray()
        
        rtnURL = NSURL()
    }
    
    
    func  getRoot() -> NSURL{
        return rootURL
    }
    
    func getProjectFolderURL(projectName:String) -> NSURL{
        return  rootURL.URLByAppendingPathComponent(projectName)
    }
    
    func getDataDictionaryURL (projectName:String , dataDictionaryName:String) -> NSURL{
        rtnURL = NSURL()
        var dictionaryNameExtended = dataDictionaryName.stringByAppendingPathExtension(".txt")
        
        rtnURL = rootURL.URLByAppendingPathComponent(projectName)
        rtnURL = rtnURL.URLByAppendingPathComponent("DataTypesDictionaries")
        rtnURL = rtnURL.URLByAppendingPathComponent(dictionaryNameExtended!)
        
        return rtnURL
        
    }
    
    func getKeyDictionaryURL (projectName:String, keyDictionaryName:String) -> NSURL{
        rtnURL = NSURL()
        var keyDictionaryNameExtended = keyDictionaryName.stringByAppendingPathExtension(".txt")
        
        rtnURL = rootURL.URLByAppendingPathComponent(projectName)
        rtnURL = rtnURL.URLByAppendingPathComponent("Keys")
        rtnURL = rtnURL.URLByAppendingPathComponent(keyDictionaryNameExtended!)
        
        return rtnURL
    }
    
    
    
}
