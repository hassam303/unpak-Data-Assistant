//
//  DataEnteringNavigationController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataEnteringNavigationController: UINavigationController {
	
	var currentMetaData:DBMetadata!
	
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		
		//Segue set-up
		let destViewController: FormMenuViewController = segue.destinationViewController as! FormMenuViewController
		
		//Passed Variables
		
		destViewController.currentMetaData = self.currentMetaData
	}
}
