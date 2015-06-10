//
//  CSVExport.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 6/9/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class CSVExport: NSObject, DBRestClientDelegate{
	
	private let restClient:DBRestClient = DBRestClient(session: DBSession.sharedSession())
	private let fileManager:NSFileManager = NSFileManager.defaultManager()
	private let rootfolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
	private var fileHandle:NSFileHandle!
	
	var filename:String

	var localFilePath:String
	
	var formService:CurrentFormEntityService
	
	var editedRows: Dictionary<String,Dictionary<String,String>>
	
	var plantIdKeys:[String]
	

	
	init(formService:CurrentFormEntityService){
		
		
		self.formService = formService
		self.editedRows = formService.getEditedRows()
		self.plantIdKeys = self.editedRows.keys.array
		
		
		
		
		
		
		//Create a new file
		
		let newFolderPath = rootfolder.stringByAppendingPathComponent("DataCheck")

		
		if !self.fileManager.fileExistsAtPath(newFolderPath){
			self.fileManager.createDirectoryAtPath(newFolderPath, withIntermediateDirectories: true, attributes: nil, error: nil)
		}
		
		var shortenedFileName:String = self.formService.getFormName()!
		shortenedFileName = shortenedFileName.stringByDeletingPathExtension
		
		var timestamp:String = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.ShortStyle , timeStyle: NSDateFormatterStyle.ShortStyle)
		timestamp = timestamp.stringByReplacingOccurrencesOfString("/", withString: ".", options: nil, range: nil)
		timestamp = timestamp.stringByReplacingOccurrencesOfString(",", withString: "@", options: nil, range: nil)
		timestamp = timestamp.stringByReplacingOccurrencesOfString(":", withString: ".", options: nil, range: nil)
		timestamp = timestamp.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		
		
		self.localFilePath = newFolderPath.stringByAppendingPathComponent(shortenedFileName + "_" + self.formService.getUserInitials()! + "_" + timestamp + ".csv")
		self.fileManager.createFileAtPath(self.localFilePath, contents: nil, attributes: nil)

		
		self.filename = self.localFilePath.pathComponents.last!
			
			
		

		
		
		
	}
	
	
	func prepareCSV(){
		
		self.restClient.loadMetadata("/")

		
		var currentHeaders:String = String()
		var currentData:String = String()
		
		var formHeaders:[String] = self.formService.getHeaders()!
		
		var currentRowInfo:Dictionary<String,String>
		
		
		
		var writeData:NSData
		self.fileHandle = NSFileHandle(forWritingAtPath: self.localFilePath)!
		self.fileHandle.seekToEndOfFile()

		
		
		
		
		//Add headers row
		for header in formHeaders{
			currentHeaders += header
			
			if header == formHeaders.last{
				break
			}
	
			currentHeaders += ","
		}
		currentHeaders += "\n"
		
		writeData = currentHeaders.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
		
		self.fileHandle.writeData(writeData)
		
		
		//Add data rows
		var sortedKeys = sorted(self.plantIdKeys, { (str1:String, str2:String) -> Bool in
			return str1 < str2
		})
		
		
		for pIDKey in sortedKeys {
			currentRowInfo = self.editedRows[pIDKey]!
			
			
			for key in formHeaders{
				
				currentData += currentRowInfo[key]!
				
				if key == formHeaders.last{
					break
				}
				
				currentData += ","
			}
			
			currentData += "\n"
			
			writeData = currentData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
			fileHandle.writeData(writeData)
			
			
			currentData = String()
		}
		
		
		self.fileHandle.closeFile()
	}


	
	
	
}
