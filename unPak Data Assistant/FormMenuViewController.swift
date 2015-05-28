//
//  FormMenuViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/20/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

class FormMenuViewController: UIViewController, DBRestClientDelegate {
	
	// Variables used to download CSV file to local directories
	
		// Local Objects
		let fileManager: NSFileManager = NSFileManager.defaultManager()
	
		let rootURL = NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true, error: nil)
	
		var tempCSVsURL:NSURL!
	
		// Dropbox Objects
		let restClient: DBRestClient = DBRestClient(session: DBSession.sharedSession())
	
	
	
	
	// Interface outlets
	@IBOutlet weak var formNameLabel: UILabel!
	@IBOutlet weak var initalsTextField: UITextField!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	
	
	
	// Class variables for CoreData
	
		// Reference to AppDelegate
		let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	
		// Initialize fetch request object (TO: NewFormEntity)
		let fetch: NSFetchRequest = NSFetchRequest(entityName:"NewFormEntity")
	
		// NSMangedObject to be recieved from CoreData after segue
		var currentForm: NSManagedObject!
	
	
	
	
	
	// Variables received through interface
	var userInitials:String!
	
	
	
	// Alert window variables
	var alert:UIAlertController!
	var retryButtonActionStyle: UIAlertActionStyle!
	var retryButtonActionForAlertWindow: UIAlertAction!
	
	
		//Error message strings to be displayed in alert box
	
		let NO_INITIAL_ENTERED:String = "Enter your initials before continuing."
	
	
	
	override func viewDidAppear(animated: Bool) {
		// Reference managed object context
		
		let contxt: NSManagedObjectContext = self.appDel.managedObjectContext!
		let ent: NSEntityDescription = NSEntityDescription.entityForName("NewFormEntity", inManagedObjectContext: contxt)!
		
		// Local array variable containing ALL available NewFormEntity Objects
		let fetchRequestArray:Array<AnyObject> = contxt.executeFetchRequest(self.fetch, error: nil)!
		
		// Get current form from fetchRequestArray
		self.currentForm = fetchRequestArray.last as! NSManagedObject
		
		// Display form name
		self.formNameLabel.text = self.currentForm.valueForKey("formName") as? String

		
		
		//Test prints 
		println("Current form properly assigned")
		
		
		
		
		
		
		
		
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.activityIndicator.hidesWhenStopped = true
		self.activityIndicator.color = UIColor.greenColor()

		
		//Initialze tempCSVsURL
		self.tempCSVsURL = self.rootURL!.URLByAppendingPathComponent("tempCSVs", isDirectory: true)
		
		//Check to ensure tempCSVs folder is exsistant
		if !self.fileManager.fileExistsAtPath(tempCSVsURL.path!){
			self.fileManager.createDirectoryAtURL(tempCSVsURL, withIntermediateDirectories: true, attributes: nil, error: nil)
			println("Created local temp folder for CSVs")
		}
		
		//Complete DBRestClient initiation 
		self.restClient.delegate = self 
		
		
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
		
		//Ensure initials textfield is filled
		if !self.initalsTextField.hasText(){
			self.presentViewController(alert, animated: true, completion: nil)

		}
		
		else {
			//Set user initials to NewForm Managed object
			self.currentForm.setValue(self.initalsTextField.text, forKey: "userInitials")
			
			//Download current form to a local directory
			self.downloadCurrentForm()
			
			var newFilePath: String = self.tempCSVsURL.URLByAppendingPathComponent(self.currentForm.valueForKey("formName") as! String, isDirectory: false).path!
			
			var newFileDownloaded:Bool = false
			
			self.activityIndicator.startAnimating()
			
			
			
		
			//Segue to collection view
			
			if self.fileManager.fileExistsAtPath(newFilePath){
			self.performSegueWithIdentifier("toCollectionFromFormSegue", sender: nil)
			}
		}
	}
	
	//Private self contained call to download current form to tempCSVs local folder for manipulation
	private func downloadCurrentForm(){
		self.restClient.loadFile(self.currentForm.valueForKey("formPath") as! String, intoPath: self.tempCSVsURL.path)

	}
	
	//RestClient delegation methods to handle file downloading
	func restClient(client: DBRestClient!, loadedFile destPath: String!, contentType: String!, metadata: DBMetadata!) {
		println("File was properly downloadedfrom:" + metadata.path)
		println("Saved to:" + destPath)
	}
	
	func restClient(client: DBRestClient!, loadFileFailedWithError error: NSError!) {
		println("File was not downloaded, whomp, whomp")
	}
	
	

}
