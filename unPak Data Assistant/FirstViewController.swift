//
//  FirstViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/15/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DBRestClientDelegate,UITableViewDataSource,UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	
	var restClient:DBRestClient?
	var availableFormsArray:[String] = Array<String>()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.restClient = DBRestClient(session: DBSession.sharedSession())
		self.restClient!.delegate = self
		self.restClient!.loadMetadata("/OpenForms")
		
		self.tableView.dataSource = self

		
		
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
				
				var dbResult:DBChooserResult = results [0] as! DBChooserResult
				
				println(dbResult.link)
				
			}
				
			else {
				println("User canceled selection")
			}
		})
		
	}
	
	@IBAction func refreshButtonPressed(sender: AnyObject) {
		tableView.reloadData()
	}
	
	
	//RestClient delegate actions
	func restClient(client: DBRestClient!, loadedMetadata metadata: DBMetadata!) {
		if metadata.isDirectory{
			for item in metadata.contents{
				println(item.filename!!)
				availableFormsArray.append(item.filename!!)
			}
		}
	}
	
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("openFormsCell") as! UITableViewCell
		let iP = indexPath
		cell.textLabel!.text = availableFormsArray[iP.row]
		
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.availableFormsArray.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	
}

