//
//  FormMenuViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/20/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class FormMenuViewController: UIViewController {
	
	
	
	
	
	// Interface outlets
	@IBOutlet weak var formNameLabel: UILabel!
	@IBOutlet weak var initalsTextField: UITextField!
	
	
	
	// Variables recieved through segue
	var currentMetaData:DBMetadata!
	
	
	// Variables received through interface
	var userInitials:String!
	
	
	
	
	// Alert window variables
	var alert:UIAlertController!
	var retryButtonActionStyle: UIAlertActionStyle!
	var retryButtonActionForAlertWindow: UIAlertAction!
	
	
		//Error message strings to be displayed in alert box
	
		let NO_INITIAL_ENTERED:String = "Enter your initials before continuing."
	
	// Class variables
	
	let userDefaults:NSUserDefaults = NSUserDefaults()

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.formNameLabel.text = self.currentMetaData.filename
		
		//Set-up alert window
		alert = UIAlertController(title: "No initials Entered!", message: self.NO_INITIAL_ENTERED, preferredStyle: UIAlertControllerStyle.Alert)
		
		retryButtonActionStyle = UIAlertActionStyle.Default
		
		retryButtonActionForAlertWindow = UIAlertAction(title: "Retry", style: retryButtonActionStyle, handler: nil)
		
		alert.addAction(retryButtonActionForAlertWindow)
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func submitButtonWasPressed(sender: AnyObject) {
		
		if !self.initalsTextField.hasText(){
			self.presentViewController(alert, animated: true, completion: nil)

		}
		
		else {
			self.userInitials = self.initalsTextField.text
			
			self.performSegueWithIdentifier("toCollectionFromFormSegue", sender: nil)
		}
	}
	
	
	

}
