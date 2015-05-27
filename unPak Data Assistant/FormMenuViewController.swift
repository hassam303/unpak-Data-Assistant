//
//  FormMenuViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/20/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

class FormMenuViewController: UIViewController {
	
	
	// Interface outlets
	@IBOutlet weak var formNameLabel: UILabel!
	@IBOutlet weak var initalsTextField: UITextField!
	
	
	
	// Variables recieved from CoreData after segue
	
	
	// Variables received through interface
	var userInitials:String!
	
	
	
	
	// Alert window variables
	var alert:UIAlertController!
	var retryButtonActionStyle: UIAlertActionStyle!
	var retryButtonActionForAlertWindow: UIAlertAction!
	
	
		//Error message strings to be displayed in alert box
	
		let NO_INITIAL_ENTERED:String = "Enter your initials before continuing."
	
	
	
	override func viewDidAppear(animated: Bool) {
		// Reference to AppDelegate
		
		let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		// Reference managed object context & Fetch request
		
		let contxt: NSManagedObjectContext = appDel.managedObjectContext!
		let ent: NSEntityDescription = NSEntityDescription.entityForName("NewFormEntity", inManagedObjectContext: contxt)!
		let fetch: NSFetchRequest = NSFetchRequest(entityName:"NewFormEntity")
		
		
		let fetchRequestArray:Array<AnyObject> = contxt.executeFetchRequest(fetch, error: nil)!
		
		var currentForm: AnyObject? = fetchRequestArray.first
		
		println(currentForm)
		
		
		
		
		
		
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
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
