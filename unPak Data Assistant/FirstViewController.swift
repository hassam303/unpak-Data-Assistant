//
//  FirstViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/15/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,DBRestClientDelegate,UITableViewDataSource,UITableViewDelegate {
	
	
	
	@IBOutlet weak var tableView: UITableView!
	
	
	let formService:CurrentFormEntityService = CurrentFormEntityService(useLatest: false)
	
	var restClient:DBRestClient?
	var availableFormsArray:[AnyObject] = Array<AnyObject>()
	var currentFilePath:String?
	
	
	//	//Set up alert window
	var alert:UIAlertController!
	var openFileButtonActionStyle: UIAlertActionStyle!
	var openFileButtonActionForAlertWindow: UIAlertAction!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.restClient = DBRestClient(session: DBSession.sharedSession())
		self.restClient!.delegate = self
		self.restClient!.loadMetadata("/Data_Assistant_Files/OpenForms")
		
		self.tableView.dataSource = self
		
		
		
		//Set-up alert window
		self.alert = UIAlertController(title: "", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
		
		self.openFileButtonActionStyle = UIAlertActionStyle.Default
		self.openFileButtonActionForAlertWindow = UIAlertAction(title: "Open", style: openFileButtonActionStyle!, handler: nil)
		
	
		self.alert.addAction(openFileButtonActionForAlertWindow!)
		print("Done")
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
	//UI Related Actions
	@IBAction func signInWasPressed(sender: AnyObject) {
		
		   DBSession.sharedSession().linkFromController(self)
		
	}
	
	@IBAction func chooserSelected(sender: AnyObject) {
		
		DBChooser.defaultChooser().openChooserForLinkType(DBChooserLinkTypePreview, fromViewController: self, completion: { (results: [AnyObject]!) -> Void in
			
			if results != nil {
				
				let dbResult:DBChooserResult = results [0] as! DBChooserResult
				
				print(dbResult.link)
				
			}
				
			else {
				print("User canceled selection")
			}
		})
		
	}
	
	@IBAction func refreshButtonPressed(sender: AnyObject) {
		tableView.reloadData()
	}
	
	
	//RestClient delegate actions
	func restClient(client: DBRestClient!, loadedMetadata metadata: DBMetadata!) {
		if metadata.isDirectory{
			self.availableFormsArray = metadata.contents
		}
	}
	
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.availableFormsArray.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("openFormsCell") as UITableViewCell!
		let iP = indexPath
		cell.textLabel!.text = availableFormsArray[iP.row].filename
		
		return cell
	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		//Segue set-up
		
		
		let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
		
	
		// Transfer properties

		self.formService.setPath(availableFormsArray[indexPath.row].path!)
		self.formService.setName(availableFormsArray[indexPath.row].filename!!)
	
		
	

	}

	

	
}

