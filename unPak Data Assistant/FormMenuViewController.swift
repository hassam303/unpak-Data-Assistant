//
//  FormMenuViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/20/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData
import SwiftCSV

class FormMenuViewController: UIViewController, DBRestClientDelegate {
	
	// Variables used to download CSV file to local directories
	
		// Local Objects
		let fileManager: NSFileManager = NSFileManager.defaultManager()
	
		let rootURL = NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true, error: nil)
	
		var tempCSVsURL:NSURL!
	
		// Dropbox Objects
		let restClient: DBRestClient = DBRestClient(session: DBSession.sharedSession())
	
	
	
	
	// Variables for parsing CSV and passing to PlantIdCollectionViewController

	var newFilePath:String!
	var newFileURL:NSURL!
	
	var csvFile: CSV?
	var csvHeaders:[String]!
	var csvRows: [Dictionary<String, String>]!

	
	
	// Interface outlets
	@IBOutlet weak var statusView: UIView!
	@IBOutlet weak var formNameLabel: UILabel!
	@IBOutlet weak var initalsTextField: UITextField!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var statusLabel: UILabel!
	
	
	
	
	
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
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.statusView.hidden = true
		
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
		
		
		
		
		// Assign form
			// Reference managed object context
		
			let contxt: NSManagedObjectContext = self.appDel.managedObjectContext!
			let ent: NSEntityDescription = NSEntityDescription.entityForName("NewFormEntity", inManagedObjectContext: contxt)!
		
			// Local array variable containing ALL available NewFormEntity Objects
			let fetchRequestArray:Array<AnyObject> = contxt.executeFetchRequest(self.fetch, error: nil)!
		
			// Get current form from fetchRequestArray
			self.currentForm = fetchRequestArray.last as! NSManagedObject
		
			//Test prints
			println("Current form properly assigned")
		
		
	}

	override func viewDidAppear(animated: Bool) {
		// Display form name
		self.formNameLabel.text = self.currentForm.valueForKey("formName") as? String
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
	
			self.statusView.hidden = false
			self.statusLabel.text = "Downloading file from Dropbox"
			self.activityIndicator.startAnimating()
			
			//Establish a separated thread for excuting file download and parsing
			
			self.downloadCurrentForm()
		
		
		}
	}
	
	//Private self contained call to download current form to tempCSVs local folder for manipulation
	private func downloadCurrentForm(){

		self.newFilePath = self.tempCSVsURL.path?.stringByAppendingPathComponent(self.currentForm.valueForKey("formName") as! String)

		self.restClient.loadFile(self.currentForm.valueForKey("formPath") as! String, intoPath: self.newFilePath)

	}
	
	//RestClient delegation methods to handle file downloading ***Also contains code for initiating CSV Parsing*** (
		//Parsing code added here to emphasize that file is both downloaded and then parsed,MAY NEED FURTHER STREAMLINING
	
	func restClient(client: DBRestClient!, loadedFile destPath: String!, contentType: String!, metadata: DBMetadata!) {
		println("Successful Download")
		
		self.statusLabel.text = "Preparing worksheet"
		
		self.newFileURL = NSURL(fileURLWithPath: self.newFilePath, isDirectory: false)!
		
		
		
		self.performSegueWithIdentifier("toCollectionFromFormSegue", sender: nil)


		
	
	}
	
	func restClient(client: DBRestClient!, loadFileFailedWithError error: NSError!) {
		println("File was not downloaded, whomp, whomp")
	}
	
	private func parseCSV(fileURL:NSURL,segue:UIStoryboardSegue) {
		
		
		var error:NSErrorPointer = nil
		self.csvFile = CSV(contentsOfURL: fileURL, error: error)
		
		
		
		self.csvHeaders = self.csvFile!.headers
		
		self.csvRows = self.csvFile!.rows
		
		self.statusLabel.text = "Done!"
		self.activityIndicator.stopAnimating()
		
		
		let vc:PlantIdCollectionViewController = segue.destinationViewController as! PlantIdCollectionViewController
		
		vc.csvHeadersArray = self.csvHeaders
		vc.csvRowsDataArray = self.csvRows
		vc.csvplantIdArray = self.csvFile!.columns["Plant ID"]!
		
		
		
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		self.parseCSV(self.newFileURL, segue: segue)
		
	}


	

	

}
