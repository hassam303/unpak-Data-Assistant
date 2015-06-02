//
//  DataEntryViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	
	var dataPointsHeaders:Array<String>!
	
	
	@IBOutlet weak var plantIdLabel: UILabel!	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		println(self.dataPointsHeaders.count)
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	@IBAction func pressed(sender: AnyObject) {
		self.tableView.reloadData()
		
	}
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataPointsHeaders.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("dataPointsCell") as! UITableViewCell
		let iP = indexPath
		cell.textLabel!.text = self.dataPointsHeaders[iP.row]
		
		return cell
	}
	
	
}
