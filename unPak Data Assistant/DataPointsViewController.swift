//
//  DataPointsViewController.swift
//  unPak Data Assistant
//
//  Created by Hassam Solano on 5/22/15.
//  Copyright (c) 2015 Hassam Solano. All rights reserved.
//

import UIKit

class DataPointsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	let NAVIGATION_TITLE:String = "Data Points"
	
	var rowInfoForPlantId:[String:String]!
	var dataPointsHeaders:Array<String>!
	var plantID:String!
	
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	


	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.dataSource = self
		self.plantID = self.rowInfoForPlantId ["Plant ID"]
		self.idLabel.text = self.plantID
		
	}
	override func viewDidAppear(animated: Bool) {
		navigationItem.title = self.NAVIGATION_TITLE
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	//UITableView Set-Up
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataPointsHeaders.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("dataPointsCell") as! UITableViewCell
		let iP = indexPath
		cell.textLabel!.text = self.dataPointsHeaders[iP.row]
		
		return cell
	}
	

	

	
	
}
