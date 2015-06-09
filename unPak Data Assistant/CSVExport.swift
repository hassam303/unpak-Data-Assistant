//
//  CSVExport.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 6/9/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class CSVExport: NSObject, DBRestClientDelegate{
	
	let restClient:DBRestClient = DBRestClient(session: DBSession.sharedSession())
	let fileManager:NSFileManager = NSFileManager.defaultManager()
	

	var localFilePath:String
	
	var formService:CurrentFormEntityService
	
	var editedRows: Dictionary<String,Dictionary<String,String>>
	
	var plantIdKeys:[String]
	
	let rootfolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

	
	init(formService:CurrentFormEntityService){
		
		self.formService = formService
		self.editedRows = formService.getEditedRows()
		self.plantIdKeys = self.editedRows.keys.array
		
		
		//Create a new file
		
		let newFolderPath = rootfolder.stringByAppendingPathComponent("DataCheck")

		
		if !self.fileManager.fileExistsAtPath(newFolderPath){
			self.fileManager.createDirectoryAtPath(newFolderPath, withIntermediateDirectories: true, attributes: nil, error: nil)
		}
		
		
		self.localFilePath = newFolderPath.stringByAppendingPathComponent(self.formService.getFormName()! + "_" + self.formService.getUserInitials()!)
		
		

//		if let outputStream = NSOutputStream(toFileAtPath: path, append: true) {
//			outputStream.open()
//			let text = "some text"
//			outputStream.write(text)
//			
//			outputStream.close()
//		} else {
//			println("Unable to open file")
//		}

		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	private func prepareCSV(){
		
		var currentString:String = String()
		
		var formHeaders:[String] = self.formService.getHeaders()!
		
		var currentRowInfo:Dictionary<String,String>
		var currentRowInfoKeys:[String]
		
		//Add headers row
		for header in formHeaders{
			currentString += header
			
			if header == formHeaders.last{
				currentString += ","
			}
	
			
		}
		
		
		println(currentString)
		
		//Add data rows
		for pIDKey in self.plantIdKeys {
			currentRowInfo = self.editedRows[pIDKey]!
			
			
			for key in formHeaders{
				
				currentString += currentRowInfo[key]!
				
				if key == formHeaders.last{
					break
				}
				
				currentString += ","
				
				
			}
		}
		
		
		
	}
	
	
	private func uploadToDropbox(fromPath:String){
	
		
	}
	
	
	
	
	
	
	
}
