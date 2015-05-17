//
//  RestClientServie.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/16/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class RestClientService: DBRestClient, DBRestClientDelegate {
	
	var returnArray:Array<AnyObject>?
	var returnAccountInfo: DBAccountInfo?
	
	override init() {
		super.init(session:DBSession.sharedSession())
		self.delegate = self
		self.returnArray! = Array<AnyObject>()
	}
	
	
	//Public Method Calls
	func getFileList (path:String) -> Array<AnyObject> {
		self.loadMetadata(path)
		return returnArray!
	}
	
	func getAccountInfo() -> DBAccountInfo {
		self.loadAccountInfo()
		return returnAccountInfo!
	}
	
	func getFile(downloadFile:String, destinationPath:String) {
		self.loadFile(downloadFile, intoPath: destinationPath)
	}
	

	
	//RestClient Delegation
	private func restClient(client: DBRestClient!, loadedMetadata metadata: DBMetadata!) {
		if metadata.isDirectory{
			returnArray = metadata.contents
			
		}
	}
	
	private func restClient(client: DBRestClient!, loadedAccountInfo info: DBAccountInfo!) {
		self.returnAccountInfo! = info
	}
	
	private func restClient(client: DBRestClient!, loadedFile destPath: String!) {
		println("File loaded into path: %@", destPath)
	}
	
}


