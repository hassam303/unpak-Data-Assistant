//
//  ParseCSV.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/29/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class ParseCSV {
	
	var fileURL:NSURL
	var plantIdArray:Array<String>
	var csv:CSV
	
	
	init (fileURL:NSURL){
		self.fileURL = fileURL
		self.plantIdArray = []
		self.csv = CSV(contentsOfURL: fileURL, error: nil)!
		
	}
	
	func getHeaders() -> Dictionary<String, [String]> {
		
		return self.csv.columns
	}
	
	
	
	
	
	
}
