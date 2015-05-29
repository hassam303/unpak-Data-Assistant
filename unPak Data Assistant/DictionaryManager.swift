//
//  DictionaryManager.swift
//  Background testing
//
//  Created by Hassam Solano on 4/3/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit


class DictionaryManager{
    
    private var rootURl:NSURL!
    private var projectFolderURL:NSURL!
    private var dictionaryURL:NSURL!
    private var fileURLObject:FileURL!
    private var fileManager:NSFileManager!
    
    init(projectName:String){
        
        fileURLObject = FileURL()
        
        rootURl = fileURLObject.getRoot()
        projectFolderURL = fileURLObject.getProjectFolderURL(projectName)
        
        
    }
    
    func createDictionary(folder:String, dictionaryName:String) -> Bool? {
        var dictionaryToBeCreatedURL:NSURL = rootURl.URLByAppendingPathComponent(folder).URLByAppendingPathComponent(dictionaryName)
        var dictionaryToBeCreatedString: String = dictionaryToBeCreatedURL.path!
        if fileManager.fileExistsAtPath(dictionaryToBeCreatedString){
            return false
        }
        else {
            fileManager.createDirectoryAtURL(dictionaryToBeCreatedURL, withIntermediateDirectories: true, attributes: nil, error: nil)
            return true
        }
        
    }
    
    
    func getKeyDictionary(projectName:String , keyDictionaryName:String ) -> NSMutableDictionary{
        dictionaryURL = fileURLObject.getKeyDictionaryURL(projectName, keyDictionaryName:keyDictionaryName)
        return NSMutableDictionary(contentsOfURL: dictionaryURL!)!
        
    }
    
    func getDataDictionary(projectName:String , dataDictionaryName:String) -> NSMutableDictionary{
        dictionaryURL = fileURLObject.getDataDictionaryURL(projectName, dataDictionaryName: dataDictionaryName)
        return NSMutableDictionary(contentsOfURL: dictionaryURL)!
    }
    
}
