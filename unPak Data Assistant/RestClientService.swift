//
//  RestClientServie.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/16/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class RestClientService: NSObject, DBRestClientDelegate  {
	let	restClient:DBRestClient

	var returnArray:Array<AnyObject> = Array<AnyObject>()
	var returnAccountInfo: DBAccountInfo?
	var loadedMetadata:DBMetadata?
	
	override init() {
		self.restClient = DBRestClient(session:DBSession.sharedSession())
		super.init()
		self.restClient.delegate = self
		
	}
	
	
	//Public Method Calls
	func getFileList (path:String) -> Array<AnyObject> {
		self.restClient.loadMetadata(path)
		
		if returnArray.count == 0 {
			println("No values")
			self.returnArray = self.loadedMetadata!.contents
			println(returnArray)
			
		}
		return returnArray
	}
	
	func getAccountInfo() -> DBAccountInfo {
		self.restClient.loadAccountInfo()
		return returnAccountInfo!
	}
	
	func getFile(downloadFile:String, destinationPath:String) {
		self.restClient.loadFile(downloadFile, intoPath: destinationPath)
	}
	

	
	//RestClient Delegation
	private func restClient(client: DBRestClient!, loadedMetadata metadata: DBMetadata!) {
			loadedMetadata! = metadata			
	}
	
	private func restClient(client: DBRestClient!, loadedAccountInfo info: DBAccountInfo!) {
		self.returnAccountInfo! = info
	}
	
	private func restClient(client: DBRestClient!, loadedFile destPath: String!) {
		println("File loaded into path: %@", destPath)
	}
	
}


